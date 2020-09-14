require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let(:javier) { create(:user) }

  before(:example) do
    javier
    session[:user_id] = javier.id
  end

  describe 'GET #new' do
    before(:example) do
      get :new
    end

    it 'assigns @article' do
      expect(assigns(:article).class).to eql(Article.new.class)
    end

    it 'renders index.html.erb' do
      expect(response).to render_template('new')
    end
  end

  describe '#create' do
    before(:example) do
      post :create, params: { article: {
        title: 'Hiking Workout',
        text: "Lorem Ipsum is simply dummy text
               of the printing and typesetting industry.
               Lorem Ipsum has been the industry's
               standard dummy text ever since the 1500s,
               when an unknown printer took a galley of type and scrambled",
        author_id: javier.id
      } }
    end

    it '@article has a title Hiking Workout' do
      expect(assigns(:article).title).to eql('Hiking Workout')
    end

    it 'Checks db for article has created' do
      expect(Article.last.title).to eql('Hiking Workout')
    end
  end

  it "renders 'new' template when the params doesn't have user_id" do
    session[:user_id] = nil
    post :create, params: {
      article: {
        title: 'Some title',
        text: "Lorem Ipsum is simply dummy text
        of the printing and typesetting industry.
        Lorem Ipsum has been the industry's"
      }
    }
    expect(response).to redirect_to(form_loggin_path)
  end
end
