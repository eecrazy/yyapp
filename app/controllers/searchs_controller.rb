class SearchsController < ApplicationController
  # GET /searchs?q=title
  def index
    #@apps = Redis::Search.query("App", params[:q], :score_field => :dtimes)
    @apps  = App.search(params[:q])
  end
 
end
