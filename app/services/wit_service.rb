require 'wit'

class WitService
  attr_reader :client

  def initialize
    access_token = ENV["WIT_ACCESS_TOKEN"]
    @client = Wit.new(access_token: access_token)
  end
end
