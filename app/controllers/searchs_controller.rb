class SearchsController < ApplicationController
    # GET /searchs?q=title
  def index
    @apps = Redis::Search.query("App", params[:q], :score_field => :dtimes)
  end
 
end
