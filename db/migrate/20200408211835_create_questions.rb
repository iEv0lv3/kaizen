class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :upvotes, default: 1
      t.integer :awards

      t.timestamps

      t.references :user, foreign_key: true
    end
  end
end
