require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:javier) { create(:user) }
  let(:hiking) { create(:article, author_id: javier.id) }

  describe '#vote_decision' do
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

  describe '#display_links' do
    before(:example) { @current_user = javier }
    it 'displays the links to Logout and Write an Article if current user' do
      code = proc do
        content_tag :div, class: 'greeting' do
          link_to("Hello #{@current_user.username}",
                  user_path(@current_user),
                  class: 'text-decoration-none text-color-orange text-uppercase font-navbar') << ' | ' <<
            link_to('Log out', logout_path, class: 'text-decoration-none color-app text-uppercase font-navbar')
        end
      end
      expect(display_links(@current_user)).to eql(code.call)
    end

    it 'displays the links of logging and register if no current_user' do
      some_var = nil
      code = content_tag :div, class: 'greeting' do
        link_to('Log in',
                form_loggin_path,
                class: 'text-decoration-none color-app text-uppercase font-navbar') << ' | ' <<
          link_to('Register', new_user_path, class: 'text-decoration-none color-app text-uppercase font-navbar')
      end
      expect(display_links(some_var)).to eql(code)
    end
  end
end
