require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let(:ana) { create(:user, username: 'Ana') }
  let(:javier) { create(:user) }

  before(:example) do
    ana
    javier
  end

  describe '#destroy' do
    let(:friendship1) { create(:friendship, user_id: javier.id, friend_id: ana.id) }
    let(:friendship2) { create(:friendship, user_id: ana.id, friend_id: javier.id) }

    before(:example) do
      session[:user_id] = javier.id
      friendship1
      friendship2
    end

    it '#destroy(s) the Javier and Ana frienship by Javier' do
    end
  end
end
