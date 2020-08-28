require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:in_home) { create(:category, name: 'In Home') }
  let(:javier) { create(:user) }
  let(:home) { create(:article, author: javier) }

  before(:example) do
    in_home
    home
    in_home.articles << home
  end

  describe '#articles' do
    it "Shows for in_home's articles Home Workout article" do
      expect(in_home.articles.include?(home)).to eql(true)
    end
  end
end
