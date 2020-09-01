module ArticleHelper
  def sort_by_date(collection)
    collection.sort_by(&:created_at).reverse
  end

  def main_picture(collection)
    if collection.empty?
      asset_path('./app/assets/images/workout1.jpg')
    else
      cloudinary_url(sort_by_date(collection).first.main.key, resource_type: :raw)
    end
  end

  def article_title(collection)
    if collection.empty?
      'Some title'
    else
      sort_by_date(collection).first.title
    end
  end

  def article_text(collection)
    if collection.empty?
      "It'll be no use in crying like that!' said
      Alice in a melancholy tone: `it doesn't seem to
      come out among the people that walk with their
      heads down and began to cry again. There seemed
      to be sure, this generally happens when one eats
      cake, but Alice had got so much into the garden,
      and I don't believe you do either!' And the Eaglet
      bent down its head to hide a smile: some of the
      table, but it was all dark overhead; before her
      was another long passage, and the White Rabbit was
      no longer to be lost: away went Alice after it,
      and fortunately was just in time to see what was
      going to do THAT in a low, timid voice, `If you
      please, sir--' The Rabbit started violently,
      dropped the white kid gloves and the words did
      not come the same age as herself, to see if she
      was dozing off, and had to be two people."
    else
      sort_by_date(collection).first.text
    end
  end

  def more_voted_article
    Article.more_voted
  end

  def picture_more_voted
    if more_voted_article.main.attached?
      cloudinary_url(more_voted_article.main.key, resource_type: :raw)
    else
      'workout1.jpg'
    end
  end
end
