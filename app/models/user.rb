class User < ActiveRecord::Base
  extend OmniauthCallbacks
  has_many :authorizations
  validates :username, presence: true, length: { maximum: 30 },:uniqueness => true
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :authentication_keys => [:login]

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

end
