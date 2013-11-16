# -*- coding: utf-8 -*-
class AppsController < ApplicationController
  authorize_resource :only => [:new,:edit,:create,:update,:destroy]
  before_action :set_app, only: [:show, :edit, :update, :destroy]
  
  def new
    @app = App.new
    @img = Image.new
  end
   
  def create
    @app = App.new(app_params)    # Not the final implementation!
    if @app.save
      redirect_to @app
      flash[:success] = "Created App!"
    else
      render 'new'
    end
  end
  
  def show
    @comments = @app.comments.paginate(page: params[:page], :per_page => 10)
    @comment = Comment.new
  end

  def index    
    if params[:tag]
      @apps = App.tagged_with(params[:tag]).paginate(page: params[:page], :per_page => 15)
    else
      @apps = App.paginate(page: params[:page], :per_page => 15)
    end
  end
  
  def edit
    @img = Image.new
  end

  def update
    if @app.update_attributes(app_params)
      flash[:success] = "修改成功"
      redirect_to @app
    else
      render 'edit'
    end
  end

  def destroy
    @app.destroy
    redirect_to apps_path
  end

  
  private

   def set_app
    @app = App.find(params[:id])
   end
   
  def app_params
    params.require(:app).permit(:name, :icon, :ctag, :ver, 
                                :fsize, :env, :uptime,
                                :rate, :images, :tag_list, 
                                :dtimes, :desc, :author)
  end
  
end
