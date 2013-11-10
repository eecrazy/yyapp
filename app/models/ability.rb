class Ability
  include CanCan::Ability
  # need to test.
  def initialize(user)

    alias_action :edit,:update,:destroy, :to => :modify

    if user.blank?
      # not logged in
      cannot :manage, :all

    elsif user.has_role?(:admin)
      # admin
      can :manage, :all
      cannot :destroy, User do |u|
        (u.id == user.id)
      end

    elsif user.has_role?(:member)

      can :create , Comment 
      # can :create, Post
      # can :modify, Post do |post|
      #   (post.user_id == user.id)
      # end

      can :modify , User do |u|
        (u.id == user.id)
      end
      # elsif user.has_role?(:unconf_member)
      #  can :modify , User do |u|
      #     (u.id == user.id)
      #   end      

    else
      # banned or unknown situation
      cannot :manage, :all
    end

  end

  protected

end
