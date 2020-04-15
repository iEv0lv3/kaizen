require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :encrypted_password }
    it { should validate_presence_of :user_name}
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :cohort }
    it { should validate_presence_of :status }
  end

  describe 'relationships' do
    it { should have_many :questions }
    it { should have_many :answers }
    it { should have_many :comments }
    it { should have_many :votes }
  end

  describe '#award_count' do
    it 'sends back an award count', :vcr do
      user_1 = User.create(
        email: 'user_1@turing.io',
        password: 'user_1',
        first_name: 'User',
        last_name: '1',
        cohort: '1811',
        status: 1,
        so_uid: 4947551,
        gh_login: 'iEv0lv3'
      )

      expect(user_1.award_count).to eq(1)

      user_2 = User.create(
        email: 'user_1@turing.io',
        password: 'user_1',
        first_name: 'User',
        last_name: '1',
        cohort: '1811',
        status: 1,
        so_uid: 7274890,
        gh_login: 'alerrian'
      )

      expect(user_2.award_count).to eq(0)
    end
  end
end
