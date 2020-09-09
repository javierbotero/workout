require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'checks the @user is a record of user' do
      get :new
      expect(assigns(:user).class).to eql(User.new.class)
    end
  end

  describe 'POST #create' do
    before(:example) do
      post :create, params: { user: { username: 'Javier' } }
    end

    it 'checks the session[user_id] is populated with javier.id' do
      expect(session[:user_id].class).to eql(Integer)
    end

    it 'redirects to user page' do
      expect(response).to have_http_status(:redirect)
    end

    it 'renders new template when no username is given' do
      session[:user_id] = nil
      post :create, params: { user: { username: '' } }
      expect(response).to render_template('new')
    end

    it 'renders new template when username is repeated' do
      session[:user_id] = nil
      post :create, params: { user: { username: 'Javier' } }
      expect(response).to render_template(:new)
    end

    it 'renders root path when a current_user tryes to create a user' do
      post :create
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET #show' do
    let(:javier) { create(:user) }

    before(:example) do
      session[:user_id] = javier.id
      get :show, params: { id: javier.id }
    end

    it 'renders the user page' do
      expect(response).to render_template('show')
    end

    it 'shows @user.username as Javier' do
      expect(assigns(:user).username).to eql('Javier')
    end
  end

  describe 'GET #edit' do
    let(:javier) { create(:user) }

    before(:example) do
      session[:user_id] = javier.id
      get :edit, params: { id: javier.id }
    end

    it 'displays the edit view' do
      expect(response).to render_template('edit')
    end

    it 'populate @user with record javier' do
      expect(assigns(:user)).to eql(javier)
    end
  end

  describe 'POST #update' do
    let(:javier) { create(:user) }
    let(:alfonso) { create(:user, username: 'Alfonso') }

    before(:example) do
      session[:user_id] = javier.id
    end

    it 'renders edit when username is blank' do
      post :update, params: { id: javier.id, username: '' }
      expect(response).to render_template('edit')
    end

    it 'renders edit when username is repeated' do
      alfonso
      patch :update, params: { id: javier.id, username: 'Alfonso' }
    end

    it 'redirects_to show user when the update is succesfull' do
      patch :update, params: { id: javier.id, username: 'Javier New' }
      expect(User.find(javier.id).username).to eql('Javier New')
    end
  end
end
