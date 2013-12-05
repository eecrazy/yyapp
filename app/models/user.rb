class User < ActiveRecord::Base
  extend OmniauthCallbacks
  has_many :authorizations
  has_many :comments
  has_many :likes
  has_many :hates
  
  validates :username, presence: true, length: { maximum: 30 },:uniqueness => true
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :authentication_keys => [:login]

  attr_accessor :login

   # for omniauth 
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  # for cancan
  # is the user admin??
  # i drop off amin attribute ,it is not safe in some situation.
  def admin?
    Setting.admin_emails.include?(self.email)
  end
  
  def member?
    true
    #user_signed_in?
  end

  # cancan roles
  def has_role?(role)
    case role
    when :admin then admin?
      #when :conf_member then conf_member?
      #when :unconf_member then unconf_member?
    when :member then member?
    else false
    end
  end

  ## for omniauth
  def User.find_auths(provider,uid)
     Authorization.find_by_provider_and_uid(provider,
                                            uid).try(:user)
  end
  # the function can bind a omniauth to an exist user
  # but it not safe in some situation.
  def bind_service(response)
    provider = response["provider"]
    uid = response["uid"].to_s
    authorizations.create(:provider => provider , :uid => uid )
  end

  def similarity_with(user)
    # Array#& is the set intersection operator
    agreements = (self.likes.select(:app_id) & user.likes.select(:app_id)).size
    agreements += (self.hates.select(:app_id) & user.hates.select(:app_id)).size
    disagreements = (self.likes.select(:app_id) & user.hates.select(:app_id)).size
    disagreements += (self.hates.select(:app_id) & user.likes.select(:app_id)).size
    # Array#| is the set union operator
    total = (self.likes.select(:app_id) + self.hates.select(:app_id)) | (user.likes.select(:app_id) + user.hates.select(:app_id))
    return (agreements - disagreements) / total.size.to_f
  end

  def prediction_for(item)
    hive_mind_sum = 0.0
    rated_by = item.likes.size + item.hates.size
    if rated_by ==0
      rated_by = 1
    end
    item.likes.each { |u| hive_mind_sum += self.similarity_with(u.user) }
    item.hates.each { |u| hive_mind_sum -= self.similarity_with(u.user) }
    return hive_mind_sum / rated_by.to_f
  end

  def has_app_id
    all = self.likes.select(:app_id) | self.hates.select(:app_id)
    all.collect{|a| a.app_id}
  end
  
end
