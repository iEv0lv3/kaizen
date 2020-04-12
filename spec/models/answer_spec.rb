require 'rails_helper'

RSpec.describe Answer, type: :model do
  describe 'validations' do
    it { should validate_presence_of :content }
  end

  describe 'relationships' do
    it { should belong_to :user }
    it { should belong_to :question }
    it { should have_many :comments }
  end
end
