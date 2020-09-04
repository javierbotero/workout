require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  let(:ana) { create(:user, username: 'Ana') }
  let(:javier) { create(:user) }

  before(:example) do
    ana
    javier
  end

  describe '#create' do
    it 'Javier sends invitation to Ana to be friends' do
      session[:user_id] = javier.id
      get :create, params: { friend_id: ana.id }
      expect(response).to redirect_to(user_path(javier.id))
    end
  end

  describe '#confirm and #denied' do
    let(:friendship1) { create(:friendship, user_id: javier.id, friend_id: ana.id, confirmed: false ) }
    before(:example) { session[:user_id] = ana.id }

    it 'Ana #confirm(s) to be friend with Javier' do
      post :confirm, params: { friend_id: javier.id, friendship_id: friendship1.id }
      ana_id = Friendship.where(user_id: ana.id, friend_id: javier.id, confirmed: true).first.user_id
      expect(ana_id).to eql(ana.id)
    end

    it 'Ana #denied(s) friendship request from Javier' do
      post :denied, params: { friendship_id: friendship1.id } if friendship1.id
      expect { Friendship.find(friendship1.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
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
      delete :delete_friendship, params: { friend_id: ana.id }
      expect(Friendship.where(id: friendship1.id).none? && Friendship.where(id: friendship2.id).none?).to eql(true)
    end
  end
end
