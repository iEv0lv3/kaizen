require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'validations' do
    it {should validate_presence_of :content}
    it {should validate_presence_of :upvotes}
  end
  
  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :question}
  end
end
