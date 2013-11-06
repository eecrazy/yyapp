class App < ActiveRecord::Base
  mount_uploader :main_image, MainImageUploader
  default_scope -> { order('created_at DESC') }
  has_many :images
end
