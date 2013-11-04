class MainPageController < ApplicationController
  def index
    if user_signed_in?
      flash[:success] = "signed"
    else
       render 'sign'
    end    
  end
  
  def sign
  end
end
