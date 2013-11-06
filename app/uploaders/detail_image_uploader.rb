# encoding: utf-8
class DetailImageUploader  < BaseUploader
  process :resize_to_fit => [nil, 200]
  
  def filename
    if super.present?
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "detail_image/#{@name}.#{file.extension.downcase}"
    end
  end

end
