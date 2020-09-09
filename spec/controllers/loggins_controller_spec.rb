require 'rails_helper'

RSpec.describe LogginsController, type: :controller do
  let(:javier) { create(:user) }

  describe '#loggin' do
    before(:example) { session[:user_id] = javier.id }

    it 'populates the session[:user_id]' do
      get :loggin, params: { username: javier.username }
      expect(session[:user_id]).to eql(javier.id)
    end

    it 'redirect to users#new if user does not exist' do
      get :loggin, params: { username: 'No name' }
      expect(response).to redirect_to(new_user_path)
    end

    it "redirect_to user_path if there's a current_user" do
      get :loggin, params: { username: javier.username }
      expect(response).to redirect_to(root_path)
    end
  end

  describe '#logout' do
    before(:example) do
      session[:user_id] = javier.id
    end

    it "deletes from session[:user_id] javier's id user" do
      get :logout if session[:user_id]
      expect(session[:user_id]).to be_nil
    end

    it 'deletes @current_user' do
      get :logout if assigns(:current_user)
      expect(assigns(:current_user)).to be_nil
    end

    it 'redirects to root_path' do
      get :logout
      expect(response).to redirect_to(root_path)
    end
  end
end
