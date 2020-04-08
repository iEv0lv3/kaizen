require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_uniqueness_of :email}
    it {should validate_presence_of :encrypted_password}
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
    it {should validate_presence_of :cohort}
    it {should validate_presence_of :status}
  end

  describe 'relationships' do
    it {should have_many :questions}
    it {should have_many :answers}
    it {should have_many :comments}
  end
end
