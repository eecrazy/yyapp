class MainPageController < ApplicationController
  def home
    #if user_signed_in?
    @apps = App.all#limit(5).order("updated_at desc")
    #else
    #   render 'sign'
    #end    
  end
  
  def sign
  end
end
