# -*- coding: utf-8 -*-
class ImageController < ApplicationController
  def create
    # 浮动窗口上传
    @img = Image.new
    @img.file = params[:Filedata]
    @app = App.find(params[:id])
    @img.app_id = @app.id
    @img.save
    full_url = Setting.domain+@img.file.url
    render :text => full_url
  end

  def destroy
    @img.destroy
  end

  private
  def image_params
    params.require(:image).permit(:file)
  end

end
