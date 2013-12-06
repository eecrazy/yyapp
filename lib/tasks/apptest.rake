# -*- coding: utf-8 -*-
namespace :db do
  desc "craw app form web "
  task crawapp2: :environment do
    require 'anemone'
    require 'nokogiri'
    #domain = "http://www.nduoa.com/package/detail/21035"
    domain = "http://www.nduoa.com/cat0?type=2"
    #domain = "http://www.nduoa.com/package/detail/7267"
    @duser  =  User.first
    Anemone.crawl(domain , :delay => 3) do |anemone|
      anemone.on_every_page do |page|
        #anemone.on_pages_like(/package\/detail\/[0-9]*$/) do | page |
        puts page.url
        if page.url.to_s.include? "package"
          puts "111"
        end
      end  
    end
    
  end
end
