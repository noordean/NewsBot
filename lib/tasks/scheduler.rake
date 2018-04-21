desc "This task is called by the Heroku scheduler add-on"
task :renew_stories => :environment do
  scraped_data = CrawlerService.new("http://dailypost.ng/hot-news/").scrape
  Politics.delete_all
  Politics.transaction do
    scraped_data.each { |scraped_datum| Politics.find_or_create_by(scraped_datum) }
  end
end
