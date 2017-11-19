require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:wiki) { Wiki.create!(title: "Demo Wiki", body: "This is a demo wiki entry", private: false) }

  describe "attributes" do
    it "has title, body, and public attributes" do
      expect(wiki).to have_attributes(title: "Demo Wiki", body: "This is a demo wiki entry", private: false)
    end
  end
end
