require 'rails_helper'

RSpec.describe ArticleHelper, type: :helper do
  let(:javier) { create(:user) }
  let(:article2) do
    create(:article,
           title: 'Second',
           created_at: '2019-10-10 20:00:00',
           author_id: javier.id,
           text: "I wonder if I know all the things
                  I used to know. Alice took up the
                  other, trying every door, she walked
                  sadly down the middle, wondering how
                  she was now about two feet high, and her
                  face brightened up at the time it all seemed
                  quite natural); but when the Rabbit actually
                  TOOK A WATCH OUT OF ITS WAISTCOAT- POCKET")
  end
  let(:article) do
    create(:article,
           title: 'First',
           created_at: '2020-10-10 20:00:00',
           author_id: javier.id,
           text: "Two change if I know all the things
                  I used to know. Alice took up the
                  other, trying every door, she walked
                  sadly down the middle, wondering how
                  she was now about two feet high, and her
                  face brightened up at the time it all seemed
                  quite natural); but when the Rabbit actually
                  TOOK A WATCH OUT OF ITS WAISTCOAT- POCKET")
  end
  let(:article3) do
    create(:article,
           title: 'Third',
           created_at: '2018-06-10 20:00:00',
           author_id: javier.id,
           text: "Three change if I know all the things
                  I used to know. Alice took up the
                  other, trying every door, she walked
                  sadly down the middle, wondering how
                  she was now about two feet high, and her
                  face brightened up at the time it all seemed
                  quite natural); but when the Rabbit actually
                  TOOK A WATCH OUT OF ITS WAISTCOAT- POCKET")
  end

  before(:example) do
    article3
    article2
    article
  end

  it '#sort_by_date the collection of articles' do
    expect(sort_by_date(Article.all).map(&:title)).to eql(%w[First Second Third])
  end
end
