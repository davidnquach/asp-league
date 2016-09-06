require 'json'

class MatchList
  attr_accessor :summoner_id, :matches, :start_index, :end_index, :total_games

  def self.matchlist(summoner_id:)
    klass = new(summoner_id)
    details = klass.info

    klass.total_games = details[:totalGames]
    klass.start_index = details[:startIndex]
    klass.end_index = details[:endIndex]
    klass.matches = details[:matches]

    klass
  end

  def initialize(summoner_id)
    @summoner_id = summoner_id
    @api = LeagueAPI.new(host: 'na.api.pvp.net', version: 'v2.2', endpoint: 'matchlist')
  end

  def info
    api.get("by-summoner/#{summoner_id}", cache_key: cache_key(summoner_id))
  end

  private

  attr_reader :api

  def cache_key(id)
    "matchlist:by-summoner:#{id}"
  end
end
