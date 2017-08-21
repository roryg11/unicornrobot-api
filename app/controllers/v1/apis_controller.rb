require 'net/http'
require 'rss'
require 'open-uri'

module V1
  class ApisController < ApplicationController
    skip_before_action :authenticate_user_from_token!

    def blog
      url = URI.parse('http://www.whentojump.com/1/feed')
      blog_items = []
      open(url) do |rss|
        feed = RSS::Parser.parse(rss)
        feed.items.each do |item|
          article = Article.new(item.title, item.link, item.description, item.category, item.content_encoded, item.pubDate)
          article.parseOutHtml()
          blog_items.push(article)
        end
        render json: blog_items, status: 200
      end
    end


  end
end
