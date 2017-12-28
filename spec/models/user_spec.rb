require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user, email: 'test@Mikeipedia.com', password: 'helloworld') }

  it { is_expected.to have_many(:wikis) }

  describe "user entry" do
    it "should contain proper email address" do
      expect(user.email).to eq('test@Mikeipedia.com')
    end

    it "should contain proper password" do
      expect(user.password).to eq('helloworld')
    end

    it "should respond to role" do
      expect(user).to respond_to(:role)
    end

    it "should respond to admin, standard, and premium" do

      expect(user).to respond_to(:standard?)
      expect(user).to respond_to(:premium?)
      expect(user).to respond_to(:admin?)
    end
  end

  describe "user roles" do
    it "is standard by default" do
      expect(user.role).to eq("standard")
    end

    context "standard user" do
      it "returns true for #standard?" do
        expect(user.standard?).to be_truthy
      end

      it "returns false for #premium?" do
        expect(user.premium?).to be_falsey
      end

      it "returns false for admin?" do
        expect(user.admin?).to be_falsey
      end
    end

    context "premium user" do
      before do
        user.premium!
      end

      it "returns true for #standard?" do
        expect(user.standard?).to be_falsey
      end

      it "returns false for #premium?" do
        expect(user.premium?).to be_truthy
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end

    context "admin user" do
      before do
        user.admin!
      end

      it "returns false for #standard?" do
        expect(user.standard?).to be_falsey
      end

      it "returns false for #premium?" do
        expect(user.premium?).to be_falsey
      end

      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
    end
  end
end
