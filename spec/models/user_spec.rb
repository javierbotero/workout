require 'rails_helper'

RSpec.describe User, type: :model do
  let(:javier) { create(:user) }
  let(:ana) { create(:user, username: 'Ana') }
  let(:andres) { create(:user, username: 'Andres') }
  let(:hiking) { create(:article, title: 'Hiking as Workout', author_id: javier.id) }
  let(:home) do
    create(:article,
           author_id: ana.id,
           text: 'Without micro-resource-constrained performance,
                  you will lack research and development. Without niches,
                  you will lack affiliate-based compliance. Without development,
                  you will lack affiliate-based compliance. What does the commonly-accepted
                  commonly-accepted standard industry term Quick: do you have a infinitely
                  reconfigurable scheme for coping with')
  end

  before(:example) do
    create(:friendship, user_id: javier.id, friend_id: ana.id)
    create(:friendship, user_id: ana.id, friend_id: javier.id)
    create(:friendship, user_id: javier.id, friend_id: andres.id, confirmed: false)
    create(:vote, article: hiking, user: javier)
    create(:vote, article: home, user: javier)
    create(:vote, article: home, user: ana)
  end

  describe '#friends' do
    it 'Javier has Ana as friend' do
      expect(javier.friends.map(&:username).include?('Ana')).to eql(true)
    end

    it 'Ana has Javier as friend' do
      expect(ana.friends.map(&:username).include?('Javier')).to eql(true)
    end

    it 'Javier is not friend of Andres' do
      expect(javier.friends.map(&:username).include?('Andres')).to eql(false)
    end
  end

  describe '#pendings' do
    it 'Javier is waiting for Andres to be friends' do
      expect(javier.pendings.map(&:friend_id).include?(andres.id)).to eql(true)
    end

    it 'Javier has a number of #friendships_pendings of one' do
      expect(javier.pendings.count).to eql(1)
    end
  end

  describe '#requests' do
    it 'Andres has Javier request to be friends' do
      expect(andres.requests.map(&:user_id).include?(javier.id)).to eql(true)
    end

    it 'Javier has no requests to be friends' do
      expect(javier.requests.count).to eql(0)
    end
  end

  describe '#votes' do
    it 'Javier has two votes' do
      expect(javier.votes.count).to eql(2)
    end

    it 'Ana has a vote for home article' do
      expect(ana.votes.map(&:article_id).include?(home.id)).to eql(true)
    end

    it 'Show ids of articles that were voted by Javier' do
      expect(javier.votes.map(&:article_id)).to eql([hiking.id, home.id])
    end
  end

  describe 'validations' do
    let(:bad_user) { build(:user, username: '') }
    let(:javier2) { build(:user) }

    it "shows invalid 'bad_user'" do
      bad_user.valid?
      expect(bad_user.errors.full_messages).to eql(["Username can't be blank",
                                                    'Username is too short (minimum is 1 character)'])
    end

    it 'shows javier2 name as repeated' do
      javier2.valid?
      expect(javier2.errors.full_messages).to eql(['Username has already been taken'])
    end
  end

  describe '#articles' do
    it "shows the first Javier's article" do
      expect(javier.articles.first).to eql(hiking)
    end
  end
end
