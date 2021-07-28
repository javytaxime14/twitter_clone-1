class AddProfilePictureToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image, :string
  end
  add_index :users, :image, unique: false
end
