class AddVerificationToAnswers < ActiveRecord::Migration[6.0]
  def change
    add_column :answers, :verification, :integer, default: 0
  end
end
