class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :upvotes, default: 1
      t.integer :awards

      t.timestamps
      t.references :commentable, polymorphic: true
    end
  end
end
