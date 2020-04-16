class AddIndexToAnswers < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :content, :text
    add_index :answers, :content
  end
end
