require 'open-uri'

class CrawlerService
  def initialize(page)
    @page = page
  end

  def scrape
    if @page == "http://dailypost.ng/hot-news/"
      scrape_daily_post
    end
  end
  
  private

  def page_docs
    scraped_docs = []
    2.times do |index|
      url = @page
      if index != 0
        url = "#{@page}page/#{index + 1}/"
      end
      scraped_docs << Nokogiri::HTML(open(url))
    end

    scraped_docs
  end

  def scrape_daily_post
    scraped_data = []
    page_docs.each do |page_doc|
      page_doc.css('.mvp-blog-story-list .mvp-blog-story-wrap').each do |story|
        link = story.css('a')[0].attributes["href"].value
        story_title = story.css('h2').text
        story_description = story.css('p').text
        scraped_story = {
          title: story_title,
          description: story_description,
          link: link
        }
        scraped_data << scraped_story
      end
    end

    scraped_data
  end
end
