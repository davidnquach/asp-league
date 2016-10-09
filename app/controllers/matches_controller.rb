class MatchesController < ApplicationController
  def create
    summoner = API::Summoner.info_by_name(summoner_params['name'])

    redirect_to matches_url(id: summoner.id, page: params['page'])
  end

  def index
    matchlist = API::MatchList.matchlist(summoner_id: params[:id])
    matches = matchlist.matches[get_range(for_page: params[:page])]

    @stats = []

    matches.each do |match_info|
      stat = Struct.new(:timestamp, :match, :champion_img, :player)
      match = API::Match.details(match_info)
      main_player = match.participant(params[:id].to_s)
      data = API::StaticData.champion_info(match_info[:champion].to_s)

      @stats << stat.new(match.timestamp, match, data.champion_img, main_player)
    end
  end

  private

  def summoner_params
    params.require(:summoner).permit(:name)
  end

  def get_range(for_page:)
    start_count = for_page.to_i * per_page
    end_count = start_count + per_page

    start_count...end_count
  end

  def per_page
    5
  end
end
