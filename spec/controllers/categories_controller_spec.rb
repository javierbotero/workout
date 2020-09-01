require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:javier) { create(:user) }
  let(:outdoors) { create(:category, name: 'Outdoors') }
  let(:indoors) { create(:category, name: 'Indoors', priority: 2) }
  let(:article1) do
    create(
      :article,
      title: 'Article 1',
      text: 'Every Bill which shall consist of a Senate and
             House of Representatives. All Debts contracted
             and Engagements entered into, before the Adoption
             of this Constitution between the States concerned
             as well as of the Congress, accept of any Law or
             Regulation therein, be discharged from such Service
             or Labour, but shall be vacated at the Expiration of
             the Senate, by granting Commissions which shall have
             passed the House of Representatives. The Seats of the
             States, and Treaties',
      author_id: javier.id
    )
  end
  let(:article2) { create(:article, author_id: javier.id) }

  before(:example) do
    session[:user_id] = javier.id
    article1.categories << outdoors
    article2.categories << indoors
  end

  describe '#index' do
    it 'populates @categories with categories' do
      get :index
      expect(assigns(:categories).map(&:name)).to eql(%w[Outdoors Indoors])
    end
  end

  describe '#show' do
    it 'shows articles that belongs to the outdoors category' do
      get :show, params: { id: outdoors.id }
      expect(assigns(:articles).first.title).to eql(article1.title)
    end

    it 'shows articles that belong to the indoors category' do
      get :show, params: { id: indoors.id }
      expect(assigns(:articles).first.title).to eql(article2.title)
    end
  end
end
