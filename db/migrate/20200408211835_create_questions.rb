class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :subject
      t.text :content
      t.integer :upvotes, default: 1
      t.integer :awards
      t.integer :forum

      t.timestamps

      t.references :user, foreign_key: true
    end
  end
end
