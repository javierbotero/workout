require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      current_user
      render plain: 'Test'
    end
  end

  describe '#current_user' do
    let(:javier) { create(:user) }
    let(:ana) { create(:user, username: 'Ana') }

    it 'Checks if @current_user is filled with a user or not' do
      session[:user_id] = javier.id
      get :index
      expect(assigns(:current_user)).to eql(javier)
    end

    it 'shows the name of @current_user as Ana' do
      session[:user_id] = ana.id
      get :index
      expect(assigns(:current_user).username).to eql('Ana')
    end
  end
end
