module SeasonMethods

  def all_coaches
    coaches_array = []
    @game_teams.each do |row|
      if coaches_array.include?(row.head_coach) == false
        coaches_array << row.head_coach
      end
    end
    coaches_array
  end


  # update to accept season argument - only reference data for that seaso

  def winningest_coach(season)

    season = season.to_i
    games_in_season = []

    @games.each do |game|
      if game.season == season
        games_in_season << game.game_id
      end
    end


    coach_wins = Hash.new(0)
    coach_losses = Hash.new(0)

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

    coach_wins.each do |name, wins|
      coach_total_games[name] = coach_losses[name] + coach_wins[name]
      coach_win_percentage[name] = coach_wins[name]/coach_total_games[name].to_f
    end


    return coach_win_percentage.max_by{|name, percentage| percentage}[0]
  end


######### WHY DOESN'T THIS WORK?
  def worst_coach(season)

    season = season.to_i
    games_in_season = []

    @games.each do |game|
      if game.season == season
        games_in_season << game.game_id
      end
    end


    coach_wins = Hash.new(0)
    coach_losses = Hash.new(0)

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

    coach_wins.each do |name, wins|
      coach_total_games[name] = coach_losses[name] + coach_wins[name]
      coach_win_percentage[name] = coach_wins[name].to_f/coach_total_games[name].to_f
    end

    # require "pry"; binding.pry

    return coach_win_percentage.min_by{|name, percentage| percentage}[0]

  end


# not correct - troubleshoot
  def most_accurate_team(season)

    season = season.to_i
    games_in_season = []

    @games.each do |game|
      if game.season == season
        games_in_season << game.game_id
      end
    end

    games_in_season.uniq

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

    # require "pry"; binding.pry

    team_id = team_accuracy.max_by{|team,accuracy| accuracy}[0]

    team_name = ""

    # can probably refactor this
    @teams.each do|team|
      if team.team_id == team_id
        team_name = team.teamName
      end
    end
    return team_name

  end





  def least_accurate_team(season)
    season = season.to_i
    games_in_season = []

    @games.each do |game|
      if game.season == season
        games_in_season << game.game_id
      end
    end

    games_in_season.uniq

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

    # require "pry"; binding.pry

    team_id = team_accuracy.min_by{|team,accuracy| accuracy}[0]

    team_name = ""

    # can probably refactor this
    @teams.each do|team|
      if team.team_id == team_id
        team_name = team.teamName
      end
    end
    return team_name
  end

  def most_tackles(season)
    games_in_season = []

    @games.each do |game|
      if game.season == season
        games_in_season << game.game_id
      end
    end

    # require "pry"; binding.pry

    team_tackles = Hash.new(0)

    @game_teams.each do |row|
      if games_in_season.include?(row.game_id)
        team_tackles[row.team_id] = team_tackles[row.team_id] + row.tackles
      end
    end

    team_array = team_tackles.max_by{|team, tackles| tackles}
    team_id = team_array[0]
    team_name = ""

    # can probably refactor this
    @teams.each do|team|
      if team.team_id == team_id
        team_name = team.teamName
      end
    end
    return team_name
  end

  def fewest_tackles(season)
    # basically the same as most tackles - maybe refactor this first
  end


end
