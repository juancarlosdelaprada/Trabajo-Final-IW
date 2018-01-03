class AddImageColumnsToBooks < ActiveRecord::Migration[5.1]
  def up
    add_attachment :books, :image
  end
  
  def down
    remove_attachment :users, :avatar
  end
end
