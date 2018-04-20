class PagesController < ApplicationController
  def index
    scraped_data = CrawlerService.new("http://dailypost.ng/hot-news/").scrape
    Politics.transaction do
      scraped_data.each { |scraped_datum| Politics.find_or_create_by(scraped_datum) }
    end
  end
end
