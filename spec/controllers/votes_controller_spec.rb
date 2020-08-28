require 'rails_helper'

RSpec.describe VotesController, type: :controller do
  let(:javier) { create(:user) }
  let(:hiking) { create(:article, author_id: javier.id) }

  before(:example) do
    session[:user_id] = javier.id
    post :create, params: { user_id: javier.id, article_id: hiking.id }
  end

  describe 'POST #create' do
    it "Gives Javier's vote to Hiking article" do
      expect(hiking.votes.last.user.username).to eql('Javier')
    end

    it 'Refresh hiking votes_count to 1' do
      hiking.reload
      expect(hiking.votes_count).to eql(1)
    end
  end

  describe 'DELETE #destroy' do
    it 'Decreases the votes to zero' do
      delete :destroy, params: { id: Vote.where(user_id: javier.id, article_id: hiking.id).first }
      hiking.reload
      expect(hiking.votes.size).to eql(0)
    end
  end
end