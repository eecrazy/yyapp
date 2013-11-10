# -*- coding: utf-8 -*-
class ImagesController < ApplicationController
  def create
    # 浮动窗口上传
       
    @app = App.find(params[:app_id])
    @img = @app.images.build(image_params)
    @img.save
    redirect_to @app
  end
  
  def destroy
    @img = Image.find(params[:id])
    @img.destroy
    redirect_to apps_path
  end

  private
  def image_params
    params.require(:image).permit(:file)
  end

end
