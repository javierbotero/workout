require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def show
      logged_in?
      render plain: 'Test logged_id?'
    end

    def index
      logged_in?
    end
  end

  before(:example) do
    routes.draw do
      get :show, to: 'anonymous#show'
      get :index, to: 'anonymous#index'
    end
  end

  describe '#current_user' do
    let(:javier) { create(:user) }
    let(:ana) { create(:user, username: 'Ana') }

    it 'shows @current_user filled with Javier instance' do
      session[:user_id] = javier.id
      get :show
      expect(assigns(:current_user)).to eql(javier)
    end

    it 'shows the name of @current_user as Ana' do
      session[:user_id] = ana.id
      get :show
      expect(assigns(:current_user).username).to eql('Ana')
    end
  end

  describe '#logged_in?' do
    it 'redirects to loggin if current_user returns false' do
      get :index
      expect(response).to redirect_to(form_loggin_path)
    end
  end
end
