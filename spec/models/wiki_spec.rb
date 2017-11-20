require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { create(:user, email: "test@blocipedia.com", password: "helloworld") }
  let(:wiki) { create(:wiki, title: "Demo Wiki", body: "This is a demo wiki entry", private: false, user: user) }

  describe "attributes" do
    it "has title, body, and public attributes" do
      expect(wiki).to have_attributes(title: "Demo Wiki", body: "This is a demo wiki entry", private: false, user: user)
    end
  end
end
