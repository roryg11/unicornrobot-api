class Article
  def initialize(title, link, description, category, raw_content, publish_date)
    @title = title
    @link = link
    @description = description
    @category = category
    @raw_content = raw_content
    @parsed_content = @raw_content
    @publish_date = publish_date
    @author = "#{description.split(" ")[0]} #{description.split(" ")[1]}"
    @subtitle = ""
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

  def raw_content
    @raw_content
  end

  def publish_date
    @publish_date
  end

  def parsedContent
    @parsed_content = @raw_content
  end

  def author
    @author
  end

  def parseOutHtml
    full_sanitizer = Rails::Html::FullSanitizer.new
    @parsed_content = full_sanitizer.sanitize(@parsed_content)
    words_array = @parsed_content.split("  ");
    check_author_names(words_array[0])
    @parsed_content = words_array
  end

  private

  def check_author_names(content)
    if content.include? "Michelle Cady"
      @author = "Michelle Cady"
    elsif content.split(" ")[0] == "By" || content.split(" ")[0] == "by"
      @author = "#{content.split(" ")[1]} #{content.split(" ")[2]}"
    else
      @author = "#{content.split(" ")[0]} #{content.split(" ")[1]}"
    end


  end

  def author_names
    ["Heidi Isern", "Philip Sopher", "Alyssa Oursler", "Michelle Cady", "Kiana Noelle", "Eric Wu", "Anna-Kay Thomas", "Michelle Cady"]
  end

  def wtj_copy
    "When to Jump is a curated community featuring the ideas and stories of people who have made the decision to leave something comfortable and chase a passion. You can follow When to Jump on Facebook, Instagram, and Twitter. For more stories like this one, sign up for the When to Jump newsletter here."
  end
end
