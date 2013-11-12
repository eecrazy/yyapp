# -*- coding:utf-8 -*-
class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :apps, through: :taggings
  default_scope -> { order('created_at DESC') }

  def self.suggest_tags(limit = 500)
    #self.order_by([[:name, :desc]]).limit(limit).map(&:_id)
    sug =[]
    self.select(:name).limit(limit).collect {
      |c| sug.push "#{c.name}"
    }
    sug
  end
  
end
