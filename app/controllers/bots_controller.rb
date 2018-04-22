class BotsController < ApplicationController
  include BotResponse

  def index
    scraped_data = CrawlerService.new("http://dailypost.ng/hot-news/").scrape
    Politics.delete_all
    Politics.transaction do
      scraped_data.each { |scraped_datum| Politics.create(scraped_datum) }
    end
  end

  def message
    wit_response = WitService.new.client.message(params[:message].strip)
    render json: bot_response_message(wit_response)
  end

  def greet
    render json: { message: "Hello! I'm a news bot. I'm here to find you news on politics. I'm not perfect but I'll try my best to make this interactive. An example could be: 'Get me some news on Buhari'" }
  end

  private

  def bot_response_message(wit_response)
    wit_entities = wit_response["entities"]
    if !wit_entities.empty?
      if wit_entities["intent"]
        { message: responses[wit_entities["intent"][0]["value"].to_sym] }
      elsif wit_entities["message"]
        search_results = Politics.search(wit_entities["message"][0]["value"])
        if search_results.empty?
          { message: "'#{wit_entities["message"][0]["value"]}' did not appear in the news today" }
        else
          { message: search_results }
        end
      end
    else
      { message: "I do not understand that. You can ask me for news and I'll get it for you. An example could be: 'Get me some news on Buhari'"}
    end
  end
end
