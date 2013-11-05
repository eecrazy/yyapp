class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name,    :null => false, :default => ""
      t.string :author,  :default => ""
      t.string :link,    :default => ""
      t.string :version,    :default => ""
      t.string :file_size,    :default => ""
      t.text :description , :default => ""
      t.text :last_updated_content,  :default => ""
      t.datetime :last_updated_at
      t.integer  :store_rate, :default => 0

      t.timestamps
    end
  end
end
