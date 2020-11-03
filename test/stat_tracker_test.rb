require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    game_path       = './data/games_dummy.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path
                }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists_and_can_access_data
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_game_ids_per_season
    assert_equal 1, @stat_tracker.game_ids_per_season.count
  end

  def test_find_team
    assert_equal "Houston Dynamo", @stat_tracker.find_team_name("3")
  end

  # Game Stats
  def test_it_calls_highest_total_score
    assert_equal 6, @stat_tracker.highest_total_score
  end

  def test_it_calls_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_calls_percentage_of_games_w_home_team_win
    assert_equal 54.0, @stat_tracker.percentage_home_wins
  end

  def test_it_calls_percentage_of_games_w_visitor_team_win
    assert_equal 43.0, @stat_tracker.percentage_visitor_wins
  end

  def test_it_calls_percentage_of_games_tied
    assert_equal 3.0, @stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected = {"20122013"=>57}
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 3.86, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {"20122013"=>3.86}
    assert_equal expected, @stat_tracker.average_goals_by_season
  end

  # Season Stats
  def test_winningest_coach
    expected = {"John Tortorella"=>0.37, "Claude Julien"=>0.54, "Dan Bylsma"=>0.52, "Mike Babcock"=>0.47, "Joel Quenneville"=>0.54, "Paul MacLean"=>0.36, "Michel Therrien"=>0.42, "Mike Yeo"=>0.26, "Darryl Sutter"=>0.45, "Ken Hitchcock"=>0.41, "Bruce Boudreau"=>0.44, "Jack Capuano"=>0.31, "Adam Oates"=>0.4, "Todd Richards"=>0.35, "Kirk Muller"=>0.38, "Peter DeBoer"=>0.33, "Dave Tippett"=>0.33, "Ron Rolston"=>0.29, "Bob Hartley"=>0.35, "Joe Sacco"=>0.29, "Ralph Krueger"=>0.38, "Randy Carlyle"=>0.44, "Kevin Dineen"=>0.25, "Todd McLellan"=>0.37, "Barry Trotz"=>0.25, "Lindy Ruff"=>0.47, "Claude Noel"=>0.35, "Peter Laviolette"=>0.31, "Glen Gulutzan"=>0.44, "Alain Vigneault"=>0.44, "Guy Boucher"=>0.48, "Jon Cooper"=>0.2, "Martin Raymond"=>0.0, "Dan Lacroix"=>1.0}
    @stat_tracker.stubs(:coach_percentage).returns(expected)
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20122013")
  end

  def test_worst_coach
    expected = {"John Tortorella"=>0.37, "Claude Julien"=>0.54, "Dan Bylsma"=>0.52, "Mike Babcock"=>0.47, "Joel Quenneville"=>0.54, "Paul MacLean"=>0.36, "Michel Therrien"=>0.42, "Mike Yeo"=>0.26, "Darryl Sutter"=>0.45, "Ken Hitchcock"=>0.41, "Bruce Boudreau"=>0.44, "Jack Capuano"=>0.31, "Adam Oates"=>0.4, "Todd Richards"=>0.35, "Kirk Muller"=>0.38, "Peter DeBoer"=>0.33, "Dave Tippett"=>0.33, "Ron Rolston"=>0.29, "Bob Hartley"=>0.35, "Joe Sacco"=>0.29, "Ralph Krueger"=>0.38, "Randy Carlyle"=>0.44, "Kevin Dineen"=>0.25, "Todd McLellan"=>0.37, "Barry Trotz"=>0.25, "Lindy Ruff"=>0.47, "Claude Noel"=>0.35, "Peter Laviolette"=>0.31, "Glen Gulutzan"=>0.44, "Alain Vigneault"=>0.44, "Guy Boucher"=>0.48, "Jon Cooper"=>0.2, "Martin Raymond"=>0.0, "Dan Lacroix"=>1.0}
    @stat_tracker.stubs(:coach_percentage).returns(expected)
    assert_equal "John Tortorella", @stat_tracker.worst_coach("20122013")
  end

  def test_most_accurate_team
    expected_3 = {"3"=>0.25, "6"=>0.27, "5"=>0.33, "17"=>0.29, "16"=>0.3, "9"=>0.25, "8"=>0.29, "30"=>0.28, "26"=>0.3, "19"=>0.3, "24"=>0.32, "2"=>0.27, "15"=>0.33, "29"=>0.31, "12"=>0.29, "1"=>0.29, "27"=>0.26, "7"=>0.31, "20"=>0.32, "21"=>0.27, "22"=>0.32, "10"=>0.34, "13"=>0.26, "28"=>0.25, "18"=>0.29, "52"=>0.3, "4"=>0.31, "25"=>0.32, "23"=>0.31, "14"=>0.37}
    @stat_tracker.stubs(:team_ratios).returns(expected_3)
    assert_equal "New York City FC", @stat_tracker.most_accurate_team("20122013")
  end

  def test_least_accurate_team
    expected_3 = {"3"=>0.25, "6"=>0.27, "5"=>0.33, "17"=>0.29, "16"=>0.3, "9"=>0.25, "8"=>0.29, "30"=>0.28, "26"=>0.3, "19"=>0.3, "24"=>0.32, "2"=>0.27, "15"=>0.33, "29"=>0.31, "12"=>0.29, "1"=>0.29, "27"=>0.26, "7"=>0.31, "20"=>0.32, "21"=>0.27, "22"=>0.32, "10"=>0.34, "13"=>0.26, "28"=>0.25, "18"=>0.29, "52"=>0.3, "4"=>0.31, "25"=>0.32, "23"=>0.31, "14"=>0.37}
    @stat_tracker.stubs(:team_ratios).returns(expected_3)
    assert_equal "Houston Dynamo", @stat_tracker.least_accurate_team("20122013")
  end

  def test_most_tackles
    assert_equal "Houston Dynamo", @stat_tracker.most_tackles("20122013")
  end

  def test_least_tackles
    assert_equal "Orlando City SC", @stat_tracker.fewest_tackles("20122013")
  end

  # League Statistics Methods
  def test_it_can_count_number_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_knows_lowest_average_goals_scored_across_season
    assert_equal 'Sporting Kansas City', @stat_tracker.best_offense
  end

  def test_it_knows_lowest_average_goals_scored_across_season
    assert_equal 'Sporting Kansas City', @stat_tracker.worst_offense
  end

  def test_it_knows_highest_scoring_away
    assert_equal 'FC Dallas', @stat_tracker.highest_scoring_visitor
  end

  def test_it_knows_highest_average_home
    assert_equal 'New York City FC', @stat_tracker.highest_scoring_home_team
  end

  def test_it_knows_lowest_average_away
    assert_equal 'Seattle Sounders FC', @stat_tracker.lowest_scoring_visitor
  end

  def test_it_knows_lowest_average_home
    assert_equal 'Orlando City SC', @stat_tracker.lowest_scoring_home_team
  end
  # League Statistics Helper Methods
  def test_it_can_find_team_name
    assert_equal 'Columbus Crew SC', @stat_tracker.find_team_name('53')
  end

  def test_it_knows_total_games_per_team_id_away
    expected = {"3"=>7, "6"=>4, "5"=>5, "17"=>8, "16"=>7, "9"=>3, "8"=>2, "30"=>3, "26"=>6, "19"=>3, "24"=>3, "2"=>3, "15"=>3}
    assert_equal expected, @stat_tracker.total_games_per_team_id_away
  end

  def test_it_knows_total_games_per_team_id_home
    expected = {"6"=>5, "3"=>5, "5"=>5, "16"=>10, "17"=>6, "8"=>3, "9"=>2, "30"=>2, "19"=>3, "26"=>5, "24"=>4, "2"=>3, "15"=>4}
    assert_equal expected, @stat_tracker.total_games_per_team_id_home
  end

  def test_it_knows_total_goals_per_team_id_away
    expected = {
                "3"=>10.0, "6"=>12.0, "5"=>8.0, "17"=>14.0, "16"=>12.0, "9"=>7.0,
                "8"=>3.0, "30"=>4.0, "26"=>11.0, "19"=>4.0, "24"=>7.0, "2"=>2.0, "15"=>6.0
              }
    assert_equal expected, @stat_tracker.total_goals_per_team_id_away
  end

  def test_it_knows_total_goals_per_team_id_home
    expected = {
                "6"=>12.0, "3"=>8.0, "5"=>9.0, "16"=>21.0, "17"=>13.0,
                "8"=>6.0, "9"=>7.0, "30"=>3.0, "19"=>6.0, "26"=>10.0,
                "24"=>10.0, "2"=>9.0, "15"=>6.0
              }
    assert_equal expected, @stat_tracker.total_goals_per_team_id_home
  end

# Team Stats
  def test_it_can_list_team_info
    expected = {
                team_id: '20',
                franchise_id: '21',
                team_name: 'Toronto FC',
                abbreviation: 'TOR',
                link: '/api/v1/teams/20'
              }
    assert_equal expected, @stat_tracker.team_info('20')
  end

  def test_it_can_find_best_season
    assert_equal '20122013', @stat_tracker.best_season('3')
  end

  def test_it_can_find_worst_season
    assert_equal "20122013", @stat_tracker.worst_season('3')
  end

  def test_it_can_find_average_win_percentage
    assert_equal 37.04, @stat_tracker.average_win_percentage('3')
  end

  def test_it_can_find_highest_goals_by_team
    assert_equal 5, @stat_tracker.most_goals_scored('3')
  end

  def test_it_can_find_fewest_goals_by_team
    assert_equal 0, @stat_tracker.fewest_goals_scored('3')
  end

  def test_it_can_find_favorite_oponent
    assert_equal 'Portland Timbers', @stat_tracker.favorite_oponent('3')
  end

  def test_it_can_find_rival
    assert_equal 'Portland Timbers', @stat_tracker.rival('3')
  end
end
