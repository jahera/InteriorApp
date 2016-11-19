class CreateContactUs < ActiveRecord::Migration
  def change
    create_table :contact_us do |t|
      t.string   :name
      t.string   :phone
      t.string   :email
      t.string   :info
      t.timestamps null: false
    end
  end
end
