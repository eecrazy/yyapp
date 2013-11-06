# encoding: utf-8
class MainImageUploader  < BaseUploader
  process :resize_to_fit => [200, 200]

  version :small do
    process :resize_to_fill => [100, 100]
  end
  
  def filename
    if super.present?
      "main_image/#{model.id}.#{file.extension.downcase}"
    end
  end

end
