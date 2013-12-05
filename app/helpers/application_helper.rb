# -*- coding: utf-8 -*-
module ApplicationHelper
    def full_title(page_title)
    base_title = "yyAPP"
    if page_title.empty?
      base_title
    else
      "#{page_title}-#{base_title}"
    end
  end
  
   # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(user, options = { size: 50 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    # if you want set a default photos , add &d= 
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "gravatar")
  end

  
  def soft_list
["必备软件","社交通讯","影音拍摄","办公理财","新闻资讯", "地图导航", "系统工具", "生活购物旅行", "壁纸主题铃声", "漫画电子书", "DIY作品"]
  end
  def game_list
    ["必备游戏", "网络游戏", "冒险闯关", "赛车竞速", "飞行射击", "益智休闲", "策略塔防", "棋牌桌游", "经营养成", "角色扮演", "体育运动", "格斗对战", "音乐游戏", "街机模拟"]
  end

  def tag_cloud(tags, classes)
    max = tags.sort_by(&:count)[-2].count
    tags.each do |tag|
      index = tag.count.to_f / max * (classes.size - 1)
      if index >0.2
        yield(tag, classes[index.round])
      end
    end
  end

  def is_like?(entity)
    if signed_in?
      if current_user.likes.where(:app_id => entity.id).count >0
        1
      else
        0
      end
    else
      2
    end
  end

  def is_hate?(entity)
    if signed_in?
      if current_user.hates.where(:app_id => entity.id).count >0
        1
      else
        0
      end
    else
      2
    end
  end

end
