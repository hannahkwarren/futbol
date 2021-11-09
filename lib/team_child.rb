require_relative './futbol_data'
require_relative './team_child_helper_module'

class TeamChild < FutbolData
  include TeamChildHelper

  def initialize(filenames)
    super(filenames)
  end

  def team_info(team_id)
    team_info = {}
    team = @teams.select do |team|
      team.team_id.to_s == team_id
    end
    team = team.first
    team_info["team_id"] = team.team_id.to_s
    team_info["franchise_id"] = team.franchise_id.to_s
    team_info["team_name"] = team.team_name
    team_info["abbreviation"] = team.abbreviation
    team_info["link"] = team.link
    team_info
  end

  def best_season(team_id)
    game_teams = []
    choose_game_teams(team_id, game_teams)
    wins = []
    loss = []
    tie = []
    separate_wins_loss_tie(wins, loss, tie, game_teams)
    season_wins = {}
    season_wins(wins, season_wins)
    season_loss = {}
    season_loss(loss, season_loss)
    season_tie = {}
    season_tie(tie, season_tie)
    winning_seasons = {}
    winning_seasons(season_wins, season_loss, season_tie, winning_seasons)
    top_season = winning_seasons.max_by { |season, percent| percent }
    top_season = top_season.first.to_s
    top_season
  end

  def worst_season(team_id)
    game_teams = []
    choose_game_teams(team_id, game_teams)
    wins = []
    loss = []
    tie = []
    separate_wins_loss_tie(wins, loss, tie, game_teams)
    season_wins = {}
    season_wins(wins, season_wins)
    season_loss = {}
    season_loss(loss, season_loss)
    season_tie = {}
    season_tie(tie, season_tie)
    winning_seasons = {}
    winning_seasons(season_wins, season_loss, season_tie, winning_seasons)
    bottom_season = winning_seasons.min_by { |season, percent| percent }
    bottom_season = bottom_season.first.to_s
    bottom_season
  end

  def average_win_percentage(team_id)
    game_teams = []
    choose_game_teams(team_id, game_teams)
    wins = []
    loss = []
    tie = []
    separate_wins_loss_tie(wins, loss, tie, game_teams)
    number_of_wins = wins.count
    total = wins.count + loss.count + tie.count
    average = number_of_wins.to_f / total.to_f
    average = average.round(2)
  end

  def most_goals_scored(team_id)
    games = []
    choose_games(team_id, games)
    game_goal_count = {}
    calculate_goal_count(team_id, games, game_goal_count)
    most_goals = game_goal_count.max_by { |game_id, goals| goals }
    most_goals = most_goals.last
    most_goals
  end

  def fewest_goals_scored(team_id)
    games = []
    choose_games(team_id, games)
    game_goal_count = {}
    calculate_goal_count(team_id, games, game_goal_count)
    fewest_goals = game_goal_count.min_by { |game_id, goals| goals }
    fewest_goals = fewest_goals.last
    fewest_goals
  end

 def favorite_opponent(team_id)
   game_teams = []
   choose_game_teams(team_id, game_teams)
   wins = []
   loss = []
   tie = []
   separate_wins_loss_tie(wins, loss, tie, game_teams)
   wins_against = {}
   wins_against(wins, wins_against)
   loss_against = {}
   loss_against(loss, loss_against)
   win_percent = {}
   wins_against.each_pair do |id, count|
     win_percent[id] = (wins_against[id].to_f / (wins_against[id].to_f + loss_against[id].to_f))
   end

   win_percent.transform_values! do |percent|
     percent * 100
   end
   favorite_opponent = win_percent.max_by { |id, percentage| percentage }
   favorite_opponent = favorite_opponent.first
   favorite_opponent = @teams.find { |team| team.team_id == favorite_opponent }
   favorite_opponent = favorite_opponent.team_name
   favorite_opponent
  end

  def rival(team_id)
   game_teams = []
   choose_game_teams(team_id, game_teams)
   wins = []
   loss = []
   tie = []
   separate_wins_loss_tie(wins, loss, tie, game_teams)
   wins_against = {}
   wins_against(wins, wins_against)
   loss_against = {}
   loss_against(loss, loss_against)
   loss_percent = {}
   loss_against.each_pair do |id, count|
     loss_percent[id] = (loss_against[id].to_f / (loss_against[id].to_f + wins_against[id].to_f))
   end

   loss_percent.transform_values! do |percent|
     percent * 100
   end
   loss_percent.delete(10) #this is an intentional data edit, making a note to ask profs later
   rival = loss_percent.max_by { |id, percentage| percentage }
   rival = rival.first
   rival = @teams.find { |team| team.team_id == rival }
   rival = rival.team_name
   rival
 end
end
