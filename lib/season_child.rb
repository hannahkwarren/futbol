require_relative './futbol_data'

class SeasonChild < FutbolData

  def initialize(filenames)
    super(filenames)
  end

  def games_in_season(season)
    season = season.to_i
    games_in_season = []

    @games.each do |game|
      if game.season == season
        games_in_season << game.game_id
      end
    end

    games_in_season
  end

  def return_team_name(team_id)
    return_team = @teams.find do|team|
      team.team_id == team_id
    end

    return return_team.team_name
  end



  def winningest_coach(season)

    games_in_season = games_in_season(season)

    coach_wins = Hash.new(0)
    coach_losses = Hash.new(0)
    coach_total_games = Hash.new(0)
    coach_win_percentage = Hash.new(0)

    @game_teams.each do |row|
      if row.result == "LOSS" && games_in_season.include?(row.game_id)
        coach_losses[row.head_coach] = coach_losses[row.head_coach] + 1
      elsif row.result == "TIE" && games_in_season.include?(row.game_id)
        coach_losses[row.head_coach] = coach_losses[row.head_coach] + 1
      elsif row.result == "WIN" && games_in_season.include?(row.game_id)
        coach_wins[row.head_coach] = coach_wins[row.head_coach] + 1
      end
    end

    coach_wins.each do |name, wins|
      coach_total_games[name] = coach_losses[name] + coach_wins[name]
      coach_win_percentage[name] = coach_wins[name].to_f/coach_total_games[name].to_f
    end

    return coach_win_percentage.max_by{|name, percentage| percentage}[0]
  end




  def worst_coach(season)

    games_in_season = games_in_season(season)

    coach_wins = Hash.new(0)
    coach_losses = Hash.new(0)

    @game_teams.each do |row|
      coach_wins[row.head_coach] = 0
      coach_losses[row.head_coach] = 0
    end

    @game_teams.each do |row|
      if row.result == "LOSS" && games_in_season.include?(row.game_id)
        coach_losses[row.head_coach] = coach_losses[row.head_coach] + 1
      elsif row.result == "TIE" && games_in_season.include?(row.game_id)
        coach_losses[row.head_coach] = coach_losses[row.head_coach] + 1
      elsif row.result == "WIN" && games_in_season.include?(row.game_id)
        coach_wins[row.head_coach] = coach_wins[row.head_coach] + 1
      end
    end

    coach_total_games = Hash.new(0)
    coach_win_percentage = Hash.new(0)

    coach_losses.each do |name, wins|
      coach_total_games[name] = coach_losses[name] + coach_wins[name]
      if coach_total_games[name] != 0
        coach_win_percentage[name] = coach_wins[name].to_f/coach_total_games[name].to_f
      end
    end

    return coach_win_percentage.min_by{|name, percentage| percentage}[0]

  end




  def most_accurate_team(season)

    games_in_season = games_in_season(season)

    team_shots = Hash.new(0)
    team_goals = Hash.new(0)

    @game_teams.each do |row|
      if games_in_season.include?(row.game_id)
        team_shots[row.team_id] += row.shots
        team_goals[row.team_id] += row.goals
      end
    end

    team_accuracy = Hash.new(0)

    team_shots.keys.each do |team|
      team_accuracy[team] = team_goals[team].to_f/team_shots[team].to_f
    end

    team_id = team_accuracy.max_by{|team,accuracy| accuracy}[0]

    return_team_name(team_id)
  end





  def least_accurate_team(season)
    games_in_season = games_in_season(season)

    team_shots = Hash.new(0)
    team_goals = Hash.new(0)
    team_accuracy = Hash.new(0)

    @game_teams.each do |row|
      if games_in_season.include?(row.game_id)
        team_shots[row.team_id] += row.shots
        team_goals[row.team_id] += row.goals
      end
    end

    team_shots.keys.each do |team|
      team_accuracy[team] = team_goals[team].to_f/team_shots[team].to_f
    end

    team_id = team_accuracy.min_by{|team,accuracy| accuracy}[0]

    return_team_name(team_id)
  end




  def most_tackles(season)
    games_in_season = games_in_season(season)

    team_tackles = Hash.new(0)

    @game_teams.each do |row|
      if games_in_season.include?(row.game_id)
        team_tackles[row.team_id] = team_tackles[row.team_id] + row.tackles
      end
    end

    team_array = team_tackles.max_by{|team, tackles| tackles}
    team_id = team_array[0]

    return_team_name(team_id)
  end

  def fewest_tackles(season)
    games_in_season = games_in_season(season)

    team_tackles = Hash.new(0)

    @game_teams.each do |row|
      if games_in_season.include?(row.game_id)
        team_tackles[row.team_id] = team_tackles[row.team_id] + row.tackles
      end
    end

    team_array = team_tackles.min_by{|team, tackles| tackles}
    team_id = team_array[0]

    return_team_name(team_id)
  end

end
