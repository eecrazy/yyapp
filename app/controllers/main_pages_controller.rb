class MainPagesController < ApplicationController
  def home
    if user_signed_in?
      @app1 = App.order("uptime desc").limit(6)
      @app2 = App.order("dtimes desc").limit(6)
      @app3 = App.order("rate desc").limit(6)
      indexs = rand_n(100,App.all.size) - current_user.has_app_id
      items = Hash.new(0)
      indexs.each do |i|
        a = App.find(i)
        items.store(a,current_user.prediction_for(a))
      end
      items = items.sort_by{|k,v| -v}
      re = items.collect { |k, v| k }
      @recommend = re[0..5]      
    else
      render 'sign'
    end    
  end

  def guess
    indexs = rand_n(40,App.all.size) - current_user.has_app_id
    items = Hash.new(0)
    indexs.each do |i|
      a = App.find(i)
      items.store(a,current_user.prediction_for(a))
    end
    maxitem = items.max_by{|k,v| v}
    @app = maxitem.first
    @val = 100 * (maxitem.second)
    
  end
  
  def sign
  end

  private
  
  def rand_n(n, max)
    randoms = Set.new
    loop do
      r = rand(max)
      if r >0
        randoms << r
      end
      return randoms.to_a if randoms.size >= n
    end
  end
  
end
