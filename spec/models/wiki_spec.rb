require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { create(:user, email: "test@Mikeipedia.com", password: "helloworld") }
  let(:wiki) { create(:wiki, title: "Demo Wiki", body: "This is a demo wiki entry", private: false, user: user) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:collaborators) }

  describe "attributes" do
    it "has title, body, and public attributes" do
      expect(wiki).to have_attributes(title: "Demo Wiki", body: "This is a demo wiki entry", private: false, user: user)
    end
  end
end
