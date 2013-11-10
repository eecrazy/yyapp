class Image < ActiveRecord::Base
  #mount_uploader :file, DetailImageUploader
  belongs_to :app
end
