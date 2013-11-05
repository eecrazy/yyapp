# -*- coding: utf-8 -*-
class AppsController < ApplicationController
  authorize_resource :only => [:new,:edit,:create,:update,:destroy]
  before_action :set_app, only: [:show, :edit, :update, :destroy]

  def new
    @app = App.new
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
  end

  def index
    @apps = App.paginate(page: params[:page], :per_page => 15)
  end
  
  def edit
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
    redirect_to root_url
  end
  
  private

   def set_app
    @app = App.find(params[:id])
   end
   
  def app_params
    params.require(:app).permit(:name, :author, :link, :version, :file_size,
                                 :description, :last_updated_at,
                                 :last_updated_content, :store_rate)
  end
  
end
