require "csv"
require_relative './game_team'

class GameTeamCollection
  attr_reader :game_team_path, :stat_tracker

  def initialize(game_team_path, stat_tracker)
    @game_team_path = game_team_path
    @stat_tracker   = stat_tracker
    @game_teams     = []
    create_game_teams(game_team_path)
  end

  def create_game_teams(game_team_path)
    data = CSV.parse(File.read(game_team_path), headers: true)
    @game_teams = data.map {|data| GameTeam.new(data, self)}
  end

end
