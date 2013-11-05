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

end
