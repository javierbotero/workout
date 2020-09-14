require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:javier) { create(:user) }
  let(:ana) { create(:user, username: 'Ana') }
  let(:hiking) { create(:article, author_id: javier.id, created_at: '2018-10-10 20:00:00') }
  let(:nature) { create(:category) }
  let(:home) { create(:article, title: 'Home Stairs', author_id: ana.id, created_at: '2018-10-10 20:00:00') }

  before(:example) do
    javier
    hiking
    nature
    create(:vote, user: ana, article: hiking)
    create(:vote, user: javier, article: hiking)
  end

  describe '#author' do
    it "shows the Hiking Workout article's author as Javier" do
      expect(hiking.author.username).to eql('Javier')
    end
  end

  describe '#votes' do
    it 'shows two votes for Hiking Workout' do
      expect(hiking.votes.count).to eql(2)
    end

    it "Shows Javier and Ana ids as hiking's voters" do
      expect(hiking.votes.map(&:user_id)).to eql([ana.id, javier.id])
    end
  end

  describe '#voters' do
    it 'shows the voters that voted for Hiking article' do
      expect(hiking.voters.map(&:username)).to eql(%w[Javier Ana])
    end

    it 'shows the ids of voters of Hiking article' do
      expect(hiking.voter_ids).to eql([javier.id, ana.id])
    end
  end

  describe '#categories' do
    it 'Shows Nature as category of Hiking Workout article' do
      hiking.categories << nature
      expect(hiking.categories.include?(nature)).to eql(true)
    end
  end

  it "#more_voted shows 'hiking' as the more voted article" do
    expect(Article.more_voted).to eql(hiking)
  end

  describe 'validations' do
    let(:no_title) { build(:article, title: '', author_id: ana.id) }
    let(:text_short) { build(:article, text: 'hajak', author_id: javier.id) }

    it 'displays error of title not being present and too short for no_title' do
      no_title.valid?
      expect(no_title.errors.full_messages_for(:title)).to eql(["Title can't be blank",
                                                                'Title is too short (minimum is 1 character)'])
    end

    it 'displays error of text too short for text_short' do
      text_short.valid?
      expect(text_short.errors.full_messages_for(:text)).to eql(['Text is too short (minimum is 100 characters)'])
    end
  end
end
