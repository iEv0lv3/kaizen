class AddIndexToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :content, :text
    add_index :comments, :content
  end
end
