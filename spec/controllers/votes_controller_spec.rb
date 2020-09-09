require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:javier) { create(:user) }
  let(:hiking) { create(:article, author_id: javier.id) }

  # before(:example) do
  #   session[:user_id] = javier.id
  #   post :create, params: { user_id: javier.id, article_id: hiking.id }
  # end

  describe 'POST #create' do
    it 'Refresh hiking votes_count to 1' do
    end
  end

  describe 'DELETE #destroy' do
    it 'Decreases the votes to zero' do
    end
  end
end
