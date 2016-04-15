require 'rails_helper'

describe User do
  let(:user) { User.new(email: 'user@example.com', password: '12345678') }

  it { should have_many(:messages) }
  it { should have_many(:comments) }

  it { should respond_to(:full_address) }
  it { should respond_to(:full_address_changed?) }

  describe '#full_address' do
    it 'it concatenates address & city & state & country' do
      user.address = "1"
      user.city    = "2"
      user.state   = "3"
      user.country = "4"
      expect(user.full_address).to eq("1 2 3 4")
    end
  end

  context 'geocoding' do
    describe 'latitude & longitude' do
      it 'should populate lat & long after address is changed' do
        expect(user.latitude).to be_nil
        expect(user.longitude).to be_nil
        user.address = "Улица УПА"
        user.save
        expect(user.latitude).to_not be_nil
        expect(user.longitude).to_not be_nil
      end
    end
  end
end
