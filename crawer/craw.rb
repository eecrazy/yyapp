require 'anemone' 

Anemone.crawl("https://play.google.com/store/apps") do |anemone|
  anemone.on_every_page do |page|
    puts page.url
  end
end
