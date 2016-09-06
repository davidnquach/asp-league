class StaticData
  attr_accessor :champion

  def self.champion_info(id)
    klass = new
    details = klass.champion_info(id)

    klass.champion = details

    klass
  end

  def initialize
    @api = LeagueAPI.new(host: 'global.api.pvp.net', api_url: 'api/lol/static-data', version: 'v1.2')
  end

  def champion_info(id)
    api.get("champion/#{id}", cache_key: cache_key(id))
  end

  def champion_img
    "http://ddragon.leagueoflegends.com/cdn/6.16.2/img/champion/#{champion[:key]}.png"
  end

  private

  attr_reader :api

  def cache_key(id)
    "static-data:champion:#{id}"
  end
end