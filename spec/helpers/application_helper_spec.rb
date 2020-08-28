require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#vote_decision' do
    let(:javier) { create(:user) }
    let(:hiking) { create(:article, author_id: javier.id) }

    before(:example) do
      javier
      hiking
      session[:user_id] = javier.id
    end

    it "returns link for create vote if Javier hasn't vote for Hiking" do
      result = vote_decision(javier.id, hiking)
      got = button_to('Vote', votes_path, method: :post, params: { article_id: hiking.id, user_id: javier.id })
      expect(result).to eql(got)
    end

    it 'returns link for delete the vote if Javier has voted for Hiking' do
      vote = create(:vote, user_id: javier.id, article_id: hiking.id)
      hiking.reload
      javier.reload
      vote.reload
      result = vote_decision(javier.id, hiking)
      expect(result).to eql(button_to('Delete Vote', vote_path(vote.id), method: :delete))
    end
  end
end
