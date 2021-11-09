require 'csv'
require 'pry'

require_relative './futbol_data'
require_relative './game_team'
require_relative './game'
require_relative './team'
require_relative './league_child'
require_relative './team_child'
require_relative './game_child'
require_relative './season_child'

class StatTracker

  def initialize(filenames)
    @league = LeagueChild.new(filenames)
    @game_child = GameChild.new(filenames)
    @team_child = TeamChild.new(filenames)
    @season_child = SeasonChild.new(filenames)
  end

  def self.from_csv(filenames)
    stat_tracker = StatTracker.new(filenames)
    stat_tracker
  end

  def highest_total_score
    @game_child.highest_total_score
  end

  def lowest_total_score
    @game_child.lowest_total_score
  end

  def percentage_home_wins
    @game_child.percentage_home_wins
  end

  def percentage_visitor_wins
    @game_child.percentage_visitor_wins
  end

  def count_of_games_by_season
    @game_child.count_of_games_by_season
  end

  def tie
    @game_child.tie
  end

  def percentage_ties
    @game_child.percentage_ties
  end

  def average_goals_per_game
    @game_child.average_goals_per_game
  end

  def average_goals_by_season
    @game_child.average_goals_by_season
  end

  def team_info(team_id)
    @team_child.team_info(team_id)
  end

  def best_season(team_id)
    @team_child.best_season(team_id)
  end

  def worst_season(team_id)
    @team_child.worst_season(team_id)
  end


  def average_win_percentage(team_id)
    @team_child.average_win_percentage(team_id)
  end

  def most_goals_scored(team_id)
    @team_child.most_goals_scored(team_id)
  end

  def fewest_goals_scored(team_id)
    @team_child.fewest_goals_scored(team_id)
  end

  def favorite_opponent(team_id)
    @team_child.favorite_opponent(team_id)
  end

  def rival(team_id)
    @team_child.rival(team_id)
  end

  def count_of_teams
    @league.count_of_teams
  end

  def best_offense
    @league.best_offense
  end

  def worst_offense
    @league.worst_offense
  end

  def highest_scoring_visitor
    @league.highest_scoring_visitor
  end

  # team with the highest average score per game, all-time, at home
  def highest_scoring_home_team
    @league.highest_scoring_home_team
  end

  # team with lowest average score per game, all-time, when playing away
  def lowest_scoring_visitor
    @league.lowest_scoring_visitor
  end

  # team with the lowest average score per game, all-time, at home
  def lowest_scoring_home_team
    @league.lowest_scoring_home_team
  end

  def winningest_coach(season)
    @season_child.winningest_coach(season)
  end

  def worst_coach(season)
    @season_child.worst_coach(season)
  end

  def most_accurate_team(season)
    @season_child.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @season_child.least_accurate_team(season)
  end

  def most_tackles(season)
    @season_child.most_tackles(season)
  end

  def fewest_tackles(season)
    @season_child.fewest_tackles(season)
  end


end

StatTracker.from_csv({ games: './data/games.csv',
                       teams: './data/teams.csv',
                       game_teams: './data/game_teams.csv' })
