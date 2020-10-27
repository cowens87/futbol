require 'csv'

class GameStats
  def self.from_csv(locations)
    GameStats.new(locations)
  end

  def initialize(locations)
    @locations = locations #this is a hash
    @games_table = CSV.parse(File.read(@locations[:games]), headers: true)
    @games_teams_table = CSV.parse(File.read(@locations[:game_teams]), headers: true)
  end

  def sum_of_scores
    @games_table.map do |game|
      game["away_goals"].to_i + game["home_goals"].to_i
    end
  end

  def highest_total_score
    sum_of_scores.max
  end

  def lowest_total_score
    sum_of_scores.min
  end

  def compare_hoa_to_result(hoa, result)
    @games_teams_table.to_a.count do |game|
      game[2] == hoa && game[3] == result
    end.to_f
  end

  def total_games
    @games_table.count
  end

  def percentage_home_wins
    (compare_hoa_to_result("home", "WIN") / total_games * 100).round(2)
  end

  def percentage_away_wins
    (compare_hoa_to_result("away", "WIN") / total_games  * 100).round(2)
  end

  def percentage_ties
    (compare_hoa_to_result("away", "TIE") / total_games  * 100).round(2)
  end

  def count_of_games_by_season
    games_per_season = {}
    @games_table.each do |game|
      if games_per_season[game["season"]]
        games_per_season[game["season"]] += 1
      else games_per_season[game["season"]] = 1
      end
    end
    games_per_season
  end

  def average_goals_per_game
    (sum_of_scores.sum / total_games.to_f).round(2)
  end

  def sum_of_scores_by_season
    scores_by_season = {}
    @games_table.each do |game|
      if scores_by_season[game["season"]]
        scores_by_season[game["season"]] += game["away_goals"].to_i + game["home_goals"].to_i
      else scores_by_season[game["season"]] = game["away_goals"].to_i + game["home_goals"].to_i
      end
    end
    scores_by_season
  end

  def season_id
    @games_table.map do |game|
      game["season"]
    end.uniq
  end

  def average_goals_by_season
    goals_per_season = {}
    season_id.each do |season|
        if !goals_per_season[season]
           goals_per_season[season]= (sum_of_scores_by_season[season] /
                                              count_of_games_by_season[season].to_f).round(2)
        end
    end
    goals_per_season
  end

end
