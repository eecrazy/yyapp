# -*- coding: utf-8 -*-
namespace :db do
  desc "init user and tag "
  task preinit: :environment do
 
    User.create!(username: "又酷又帅的神秘网友",
                 email:"yyappdefult@126.com",
                 password: "123456",
                 encrypted_password: "123456")
    
    puts "create user!"

    list = ["必备软件","社交通讯","影音拍摄","办公理财","新闻资讯", "地图导航", "系统工具", "生活购物旅行", "壁纸主题铃声", "漫画电子书", "DIY作品","必备游戏", "网络游戏", "冒险闯关", "赛车竞速", "飞行射击", "益智休闲", "策略塔防", "棋牌桌游", "经营养成", "角色扮演", "体育运动", "格斗对战", "音乐游戏", "街机模拟"]
    list.each do |tag|
      Tag.create!(name: tag)
      puts "create tags!#{tag}"
    end

  end
end
