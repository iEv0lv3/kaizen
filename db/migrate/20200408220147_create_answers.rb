class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.text :content
      t.integer :upvotes, default: 1
      t.integer :awards

      t.timestamps

      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true
    end
  end
end
