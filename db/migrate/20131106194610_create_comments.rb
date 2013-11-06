class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.references :user
      t.references :app

      t.timestamps
    end
    add_index :comments, :created_at
  end
end
