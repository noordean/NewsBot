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

  def page_doc
    Nokogiri::HTML(open(@page))
  end

  def scrape_daily_post
    scraped_data = []
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

    scraped_data
  end
end
