require 'date'

class Match
  attr_accessor :id, :participants, :timestamp

  def self.details(info)
    klass = new(info[:matchId])
    details = klass.info

    klass.participants = details[:participants].each_with_object([]) do |detail, participants|
      identity = details[:participantIdentities].find { |identity| detail[:participantId] == identity[:participantId] }
      participants << PlayerMatchDetails.new(identity: identity, match_details: detail)
    end

    klass.timestamp = Date.strptime((info[:timestamp].to_f/1000).to_s, '%s').strftime('%b %d, %Y')

    klass
  end

  def initialize(id)
    @id = id.to_s
    @api = LeagueAPI.new(host: 'na.api.pvp.net', version: 'v2.2', endpoint: 'match')
  end

  def info
    api.get(id, cache_key: cache_key(id))
  end

  def participant(participant_id)
    participants.find { |participant| participant.id.to_i == participant_id.to_i }
  end

  attr_reader :api

  private

  def cache_key(id)
    "match:#{id}"
  end
end