module Teams_Methods

  def team_info(team_name)

    team_info = {}
    team = @teams.select do |team|
      team.teamName == team_name
    end
    team = team[0]
    team_info['team_id'] = team.team_id
    team_info['franchiseId'] = team.franchiseId
    team_info['teamName'] = team.teamName
    team_info['abbreviation'] = team.abbreviation
    team_info['link'] = team.link

    team_info
  end

  def best_season(team_id)
    team_games = @games.select do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end

    wins = []
    loss_or_tie = []
    team_games.each do |game|
      if game.home_goals > game.away_goals
        wins << game
      else
        loss_or_tie << game
      end
    end

    season_wins = {}
    wins.each do |game|
      if !season_wins.keys.include?(game.season)
        season_wins[game.season] = 1 #and/or operator? From IC Review
      elsif season_wins.keys.include?(game.season)
        season_wins[game.season] += 1
      end
    end

    season_loss_or_tie = {}
    loss_or_tie.each do |game|
      if !season_loss_or_tie.keys.include?(game.season)
        season_loss_or_tie[game.season] = 1
      elsif season_loss_or_tie.keys.include?(game.season)
        season_loss_or_tie[game.season] += 1
      end
    end

    winning_seasons = {}
    season_wins.each_pair do |season, count|
      if count > season_loss_or_tie[season]
        winning_seasons[season] = (count.to_f / season_loss_or_tie[season].to_f)
      end
    end

    top_season = winning_seasons.max_by { |season, ratio| ratio }
    top_season = top_season.first.to_s
  end

  def worst_season(team_id)
    team_games = @games.select do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end

    wins = []
    loss_or_tie = []
    team_games.each do |game|
      if game.home_goals > game.away_goals
        wins << game
      else
        loss_or_tie << game
      end
    end

    season_wins = {}
    wins.each do |game|
      if !season_wins.keys.include?(game.season)
        season_wins[game.season] = 1 #and/or operator? From IC Review
      elsif season_wins.keys.include?(game.season)
        season_wins[game.season] += 1
      end
    end

    season_loss_or_tie = {}
    loss_or_tie.each do |game|
      if !season_loss_or_tie.keys.include?(game.season)
        season_loss_or_tie[game.season] = 1
      elsif season_loss_or_tie.keys.include?(game.season)
        season_loss_or_tie[game.season] += 1
      end
    end

    losing_seasons = {}
    season_loss_or_tie.each_pair do |season, count|
      if count <= season_wins[season]
        losing_seasons[season] = (count.to_f / season_wins[season].to_f)
      end
    end

    worst_season = losing_seasons.max_by { |season, ratio| ratio }
    worst_season = worst_season.first.to_s
  end


  def average_win_percentage(team_id)

    wins = 0
    loss_or_tie = 0
    rows = []

    @game_teams.each do |row|
      if row.team_id == team_id
        rows << row
      end
    end

    rows.each do |row|
      if row.result == 'WIN'
        wins += 1
      elsif row.result != 'WIN'
        loss_or_tie += 1
      end
    end

    wins = wins.to_f
    loss_or_tie = loss_or_tie.to_f
    total = wins + loss_or_tie
    percentage = (wins / total) * 100
    percentage = percentage.round(2)
    percentage
  end
end
