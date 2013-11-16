class MainPagesController < ApplicationController
  def home
    if user_signed_in?
      @app1 = App.order("uptime desc").limit(6)
      @app2 = App.order("dtimes desc").limit(6)
      @app3 = App.order("rate desc").limit(6)
    else
      render 'sign'
    end    
  end
  
  def sign
  end
end
