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

  def tag_cloud(tags, classes)
    max = tags.sort_by(&:count).last
    tags.each do |tag|
      index = tag.count.to_f / max.count * (classes.size - 1)
      yield(tag, classes[index.round])
    end
  end

end
