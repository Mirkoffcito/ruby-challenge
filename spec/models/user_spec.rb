require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation test' do
    it 'ensures presence of username' do
      user = User.new(password:'test123').save
      expect(user).to eq(false)
    end
  end
end
