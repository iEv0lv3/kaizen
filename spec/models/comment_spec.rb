require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of :content }
  end

  describe 'relationships' do
    it { should belong_to :commentable }
    it { should belong_to :user}
  end
end
