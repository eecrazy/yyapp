# -*- coding: utf-8 -*-
class LikesController < ApplicationController

  def toggle
    cho = params[:cho].to_i
    @app = App.find(params[:app_id])    
    if cho == 0
      @like = @app.likes.build #(collect_params)
      @like.user = current_user
      @like.save
    else 
      @like = Like.where(:user =>current_user, :app =>@app).first
      @like.destroy
    end

  end

  
end
