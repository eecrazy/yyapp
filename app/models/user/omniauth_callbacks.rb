# coding: utf-8
class User
  module OmniauthCallbacks
    ["github","google","weibo","douban"].each do |provider|
      define_method "find_or_create_for_#{provider}" do |response|
        uid = response["uid"]
        data = response["info"]
        #if user = User.where("authorizations.provider" => provider , "authorizations.uid" => uid).first
        if user = User.find_auths(provider,uid)
          user
          
        #  it is not safe below!!
        #  for github ,its email not need to confirmation.
       
        #elsif user = User.find_by_email(data["email"]) && provider = 'douban'
        #  user.bind_service(response)
        #  user
        else
          user = User.new_from_provider_data(provider, uid, data)

          if user.save(:validate => false)
            user.authorizations << Authorization.new(:provider => provider, :uid => uid )
            return user
          else
            Rails.logger.warn("User.create_from_hash 失败，#{user.errors.inspect}")
            return nil
          end
        end
      end
    end

    def new_from_provider_data(provider, uid, data)
      User.new do |user|
        # it is interesting that only github and google will return email
        user.login  = data["name"]
        # in fact , weibo and douban  has nickname attribute ,too . which is better?
        user.login  = data["nickname"] if provider == "github"
        # when the username is chinese , the code below will replace them by '_'
        #user.login.gsub!(/[^\w]/, "_")
        # to avoid such as "CHEN PENG"
        user.login.gsub!(/[\s]/, "_")
        #user.username = user.login
        if User.where(:username => user.login).exists? || user.login.blank?
          user.login = "#{provider}_#{uid}"
        end
        user.username = user.login
        user.email = data["email"]
        if  user.email.blank?
          user.email = "#{provider}_#{uid}@nil.com"
        elsif User.where(:email => data["email"]).exists? 
          user.email = "#{provider}_#{user.email}"
        end
        # if we use email confirmation ,we need it :
        # user.confirmed_at = user.confirmation_sent_at = Time.now.to_s
        
        user.password = Devise.friendly_token[0, 20]
        #user.location = data["location"]
        #user.tagline = data["description"]
      end
    end
  end
end
