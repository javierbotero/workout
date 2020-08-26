require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:javier) { create(:user) }
  let(:ana) { create(:user, username: 'Ana') }
  let(:hiking) { create(:article, author_id: javier.id) }
  let(:nature) { create(:category) }

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

  describe '# categories' do
    it 'Shows Nature as category of Hiking Workout article' do
      hiking.categories << nature
      expect(hiking.categories.include?(nature)).to eql(true)
    end
  end
end
