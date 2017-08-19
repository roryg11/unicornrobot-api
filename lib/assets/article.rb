class Article
  def initialize(title, link, description, category, content, publish_date)
    puts "IN THE ARTICLE INITIALIZE METHOD"
    @title = title
    @link = link
    @description = description
    @category = category
    @content = content
    @publish_date = publish_date
  end

  def title
    @title
  end

  def link
    @link
  end

  def description
    @description
  end

  def category
    @category
  end

  def content
    @content
  end

  def publish_date
    @publish_date
  end

end
