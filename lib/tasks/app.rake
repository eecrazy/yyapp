# -*- coding: utf-8 -*-
namespace :db do
  desc "craw app form web "
  task crawapp: :environment do
    require 'anemone'
    require 'nokogiri'
    #domain = "http://www.nduoa.com/package/detail/21035"
    #domain = "http://www.nduoa.com/cat0?type=2"
    domain = "http://www.nduoa.com/package/detail/189581"
    @duser  =  User.first
    Anemone.crawl(domain , :delay => 3) do |anemone|
      #anemone.on_every_page do |page|
      anemone.on_pages_like(/package\/detail\/[0-9]*$/) do | page |  
        doc = Nokogiri::HTML(open(page.url))      
        # app名称
        name = ""
        doc.css('.name span.title').each do |tag|
          name =  tag.content
        end

        puts name
        puts page.url

        next if name == ""
        next if App.where(:name => name).exists?

        icon = doc.css('.icon img')[0]["src"]

        puts icon
        
        ver =  doc.css('.version')[0].text

        puts ver

        c1 = doc.css("#breadcrumbs span a")[1].text
        c1.gsub(/[\.\,]/,'_')
        ctag = doc.css("#breadcrumbs span a")[2].text
        ctag = ctag.gsub(/[\.\,]/,'_')
        puts ctag
        
        fsize =  doc.css('.size')[0].text
        fsize = fsize.split(':').last
        puts fsize

        dtimes = ""
        str =  doc.css('.count')[0].text
        str.gsub(/\d/).each{|tag| dtimes = dtimes +tag}
        dtimes = dtimes.to_i
        
        env =  doc.css('.adapt h4')[0].text
        env = env.split(':').last
        puts env
        
        author =  doc.css('.author span a')[0].text
        author = author.gsub(/[\.\,]/,'_')
        puts author
        
        uptime = doc.css('.updateTime em')[0].text
        uptime = Date.today - uptime.gsub(/\d/).first.to_i
        
        puts uptime
        
        rate = 0;
        doc.css('.starWrap s').each do |tag|        
          rate = rate+1 if tag['class'].include? 'full'
          rate = rate + 0.5  if  tag['class'].include? 'half'                       
        end

        puts rate
        
        desc = ""
        desc = doc.css('#detailInfo .content .inner')[0].to_s
        #doc.css('.content .inner p').each{|tag| desc +=tag}
        
        puts desc
          
        @app =  App.create!(name: name,
                            icon: icon,
                            ver: ver,            
                            fsize: fsize,
                            dtimes: dtimes,
                            env: env,
                            uptime: uptime,
                            rate: rate,
                            desc: desc,
                            tag_list: "#{c1},#{ctag},#{author}"
                            )

        
        doc.css('ul.shotbox li img').each do |tag|
          @app.images.create!(file: tag["src"])
        end

        doc.css('ul.commentList li p.txt').each do |tag|
          comment = @app.comments.create!(comment: tag.text,
                                          user_id: @duser.id)
        end
        
        
      end  
    end
  end
end
