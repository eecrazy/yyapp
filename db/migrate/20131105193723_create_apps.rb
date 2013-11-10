class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name,    :null => false, :default => ""
      t.string :version,    :default => ""
      t.string :file_size,    :default => ""
      t.string :catg  , :default => ""
      t.date :last_updated_at
      t.string :lang  , :default => ""
      t.string :sys_command  , :default => ""
      t.integer :down_times  , :default => 0
      t.float  :store_rate, :default => 0

      t.text :description , :default => ""
      t.timestamps
    end
  end
end
