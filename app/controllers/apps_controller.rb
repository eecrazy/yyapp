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
    ### version1 : only can has 2 features
    # tags = @app.tags[0..-3]
    # total = comparer  = @app.tags.last.apps
    # tags.each {|t| total = t.apps | total}
    # similarer = []
    # tags.each do |t|
    #   similarer = similarer | (comparer & t.apps)
    #   total = similarer | total
    # end
    # total = total[0..6]
    # @recommend= total - [@app]
    ### version2 : useful
    tags = @app.tags
    h = Hash.new(0)
    tags.each do |t|
      t.apps.each { |v| h.store(v, h[v]+1) }
    end
    h = h.sort_by{|k,v| -v}
    arr= h.collect { |k, v| k }
    @recommend = arr[0..6] - [@app]
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

  def tag_it
    @app = App.find(params[:app_id])
    tag = Tag.where(name: params[:tag_name]).first_or_create!
    @app.tags.push(tag)
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
