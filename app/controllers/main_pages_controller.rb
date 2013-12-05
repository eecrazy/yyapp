class MainPagesController < ApplicationController
  def home
    if user_signed_in?
      @app1 = App.order("uptime desc").limit(6)
      @app2 = App.order("dtimes desc").limit(6)
      @app3 = App.order("rate desc").limit(6)
      indexs = rand_n(20,App.all.size) - current_user.has_app_id
      items = Hash.new(0)
      indexs.each do |i|
        a = App.find(i)
        items.store(a,current_user.prediction_for(a))
      end
      items = items.sort_by{|k,v| -v}
      re = items.collect { |k, v| k }
      @recommend = re[0..5]
      #@recommend = []
    else
      render 'sign'
    end    
  end
  
  def sign
  end

  private
  
  def rand_n(n, max)
    randoms = Set.new
    loop do
        randoms << rand(max)
        return randoms.to_a if randoms.size >= n
    end
  end
  
end
