require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
  let(:user) { create(:user, email: "test@Mikeipedia.com", password: "helloworld") }
  let(:wiki) { create(:wiki, title: "Demo Wiki", body: "This is a demo wiki entry", private: false, user: user) }

  describe 'POST create' do
    it 'redirects to the wikis show view' do
      post :create, { wiki_id: wiki.id }
      expect(response).to redirect_to(wiki)
    end

    it 'creates a collaborator for the input email and specified wiki' do
      expect(user.collaborators.find_by_wiki_id(wiki.id)).to be_nil
      post :create, { wiki_id: wiki.id }
      expect(user.collaborators.find_by_wiki_id(wiki.id)).not_to be_nil
    end
  end
end
