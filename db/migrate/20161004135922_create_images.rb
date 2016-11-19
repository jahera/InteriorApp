class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.timestamps null: false
      t.string  :file
      t.string  :title
      t.string  :desc
      t.string  :satus
      t.string  :category 
      t.integer :user_id
    end
  end
end
