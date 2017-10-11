class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :filename
      t.integer :user_id
      t.binary :file
      t.timestamps null: false
    end
  end
end
