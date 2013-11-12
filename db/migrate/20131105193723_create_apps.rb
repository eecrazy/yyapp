class CreateApps < ActiveRecord::Migration
  def change
    create_table :apps do |t|
      t.string :name,    :null => false, :default => "", unique: true 
      t.string :icon,     :default => ""
      t.string :ver,    :default => ""
      t.integer :dtimes  , :default => 0
      t.string :fsize,    :default => ""
      t.string :env  , :default => ""
      #t.string :ctag  , :default => ""
      #t.string :author, :default => ""
      t.date :uptime
      t.float  :rate, :default => 0      
      t.text :desc , :default => ""
      t.timestamps
    end
  end
end
