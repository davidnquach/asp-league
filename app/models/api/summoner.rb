require 'json'

module API
  class Summoner
    attr_accessor :name, :id, :profile_icon_id, :summoner_level

    def self.info_by_name(name)
      klass = new(name)
      details = klass.info
      summoner = details[name.to_sym]

      klass.id = summoner[:id]
      klass.profile_icon_id = summoner[:profileIconId]
      klass.summoner_level = summoner[:summoner_level]

      klass
    end

    def initialize(name)
      @name = name
      @api = API::LeagueAPI.new(host: 'na.api.pvp.net', version: 'v1.4', region: 'na', endpoint: 'summoner')
    end

    def info
      api.get("by-name/#{name}", cache_key: cache_key(name))
    end

    private

    attr_reader :api

    def cache_key(name)
      "summoner:by-name:#{name}"
    end
  end
end