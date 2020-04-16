class AddIndexToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :content, :text
    add_index :questions, :content
    add_column :questions, :subject, :string
    add_index :questions, :subject
    add_column :questions, :forum, :integer
    add_index :questions, :forum
  end
end
