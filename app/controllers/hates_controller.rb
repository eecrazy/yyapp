# -*- coding: utf-8 -*-
class HatesController < ApplicationController

  def toggle
    cho = params[:cho].to_i
    @app = App.find(params[:app_id])    
    if cho == 0
      @hate = @app.hates.build #(collect_params)
      @hate.user = current_user
      @hate.save
    else 
      @hate = Hate.where(:user =>current_user, :app =>@app).first
      @hate.destroy
    end

  end

  
end
