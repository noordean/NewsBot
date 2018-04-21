class BotsController < ApplicationController
  include BotResponse

  def index
    scraped_data = CrawlerService.new("http://dailypost.ng/hot-news/").scrape
    Politics.transaction do
      scraped_data.each { |scraped_datum| Politics.find_or_create_by(scraped_datum) }
    end
  end

  def message
    wit_response = WitService.new.client.message(params[:message].strip)
    render json: bot_response_message(wit_response)
  end

  private

  def bot_response_message(wit_response)
    wit_entities = wit_response["entities"]
    if !wit_entities.empty?
      if wit_entities["intent"]
        { message: responses[wit_entities["intent"][0]["value"].to_sym] }
      elsif wit_entities["message"]
        { message: Politics.search(wit_entities["message"][0]["value"]) }
      end
    else
      { message: "I do not understand that. You can ask me for news and I'll provide you. An example could be: 'Get me some news on Buhari'"}
    end
  end
end
