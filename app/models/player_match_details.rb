class PlayerMatchDetails
  attr_reader :identity, :match_details

  def initialize(identity:, match_details:)
    @identity = identity
    @match_details = match_details
  end

  def id
    identity[:player][:summonerId]
  end

  def summoner_name
    identity[:player][:summonerName]
  end

  def kills
    @kills = match_details[:stats][:kills]
  end

  def deaths
    @deaths = match_details[:stats][:deaths]
  end

  def assists
    @assists = match_details[:stats][:assists]
  end

  def kda
    sprintf('%.2f', ((kills + assists).to_f / ([1, deaths].max).to_f))
  end
end