class AddImageToApps < ActiveRecord::Migration
  def change
    add_column :apps, :main_image, :string
  end
end
