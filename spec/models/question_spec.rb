require 'rails_helper'

RSpec.describe Question, type: :model do
  describe 'validations' do
    it { should validate_presence_of :subject }
    it { should validate_presence_of :content }
    it { should validate_presence_of :upvotes }
    it { should validate_presence_of :type }
  end
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :comments }
    it { should have_many :answers }
  end
end
