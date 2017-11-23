require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  let(:user) { create(:user, email: "test@blocipedia.com", password: "helloworld") }
  let(:wiki) { create(:wiki, title: "Demo Wiki", body: "This is a demo wiki entry", private: false, user: user) }
  let(:collaborator) { Collaborator.create!(user: user, wiki: wiki) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:wiki) }
end
