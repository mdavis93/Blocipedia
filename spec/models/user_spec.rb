require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user, email: 'test@blocipedia.com', password: 'helloworld') }

  it { is_expected.to have_many(:wikis) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }

  describe "user entry" do
    it "should contain proper email address" do
      expect(user.email).to eq('test@blocipedia.com')
    end

    it "should contain proper password" do
      expect(user.password).to eq('helloworld')
    end
  end
end
