require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  let(:javier) { create(:user) }
  let(:stairs_leg) { create(:article, author_id: javier.id) }

  describe '#destroy' do
    it 'hits destroy and redirects to the edit page' do
      post :destroy, params: { article_id: stairs_leg.id }
      expect(response).to redirect_to(edit_article_path(stairs_leg.id))
    end
  end
end
