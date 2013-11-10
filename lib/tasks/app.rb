# -*- coding: utf-8 -*-

namespace :db do
  desc "Fill database with sample data"
  
  task populate: :environment do
    require 'anemone'
    require 'nokogiri'
    #domain = "http://www.wandoujia.com/apps"
    domain = "http://www.25pp.com/iphone/soft/info_741473.html"

    Anemone.crawl(domain , :delay => 3) do |anemone|
      #anemone.on_every_page do |page|
      anemone.on_pages_like(/iphone\/soft\/[^?]*$/) do | page |  
        doc = Nokogiri::HTML(open(page.url))      

        # app名称
        name =  doc.css('.head1 h2')[0].text
        # logo
        main_image = doc.css('.pic img')[0]["src"]
        # version
        version =  doc.css('.edition li span')[0].text
        # 类别
        catg = doc.css('.edition li span')[1].text
        # 大小
        file_size =  doc.css('.edition li span')[2].text
        # 时间
        last_updated_at =  doc.css('.edition li span')[3].text
        # 语言
        lang = doc.css('.edition li span')[4].text
        # 系统要求
        sys_command =  doc.css('.edition li span')[5].text
        # star
        store_rate =  doc.css('.star2 h3 span')[0].text
        # down times
        down_times = doc.css('.download_times span')[0].text
        # 介绍
        description = ""
        doc.css('#detailed p').each{|tag| description +=tag}

        puts name
        puts main_image
        puts page.url

        App.create!(name: name,
                    version: version,
                    main_image: main_image,
                    catg: catg,
                    file_size: file_size,
                    last_updated_at: last_updated_at,
                    lang: lang,
                    sys_command: sys_command,
                    down_times: down_times,
                    store_rate: store_rate,
                    description: description)
      end  
    end
  end
end



