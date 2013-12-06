# -*- coding: utf-8 -*-
class App < ActiveRecord::Base
  #include Redis::Search
  #mount_uploader :main_image, MainImageUploader
  default_scope -> { order('created_at DESC') }
  has_many :comments
  has_many :images
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :likes
  has_many :hates
  
  validates :name, :uniqueness => true
 
  
  def self.tagged_with(name)
    Tag.find_by_name!(name).apps
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end
  
  def tag_list
    tags.map(&:name).join(", ")
  end
  
  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
  
  def is_game?
    self.tags[-1].name =="游戏"
  end
  def is_soft?
    self.tags[-1].name =="软件"
  end
  
  # redis_search_index(:title_field => :name,
  #                    :score_field => :dtimes,
  #                    :prefix_index_enable => true,
  #                    :condition_fields => [:is_game?, :is_soft?],
  #                    :ext_fields => [:name,:icon,:uptime,:rate,:dtimes])

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
  
end
