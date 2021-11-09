module TeamChildHelper
  
  def choose_games(team_id, games)
    @games.each do |game|
      if game.away_team_id.to_s == team_id || game.home_team_id.to_s == team_id
        games << game
      end
    end
  end

  def choose_game_teams(team_id, game_teams)
    @game_teams.each do |row|
      if row.team_id == team_id.to_i
        game_teams << row
      end
    end
  end

  def separate_wins_loss_tie(wins, loss, tie, game_teams)
    game_teams.each do |row|
      if row.result == 'WIN'
        wins << row
      elsif row.result == 'LOSS'
        loss << row
      elsif row.result == 'TIE'
        tie << row
      end
    end
  end

  def season_wins(wins, season_wins)
    wins.each do |row|
      @games.each do |game|
        if row.game_id == game.game_id
          season_wins[game.season] ||= 0
          season_wins[game.season] += 1
        end
      end
    end
  end

  def season_loss(loss, season_loss)
    loss.each do |row|
      @games.each do |game|
        if row.game_id == game.game_id
          season_loss[game.season] ||= 0
          season_loss[game.season] += 1
        end
      end
    end
  end

  def season_tie(tie, season_tie)
    tie.each do |row|
      @games.each do |game|
        if row.game_id == game.game_id
          season_tie[game.season] ||= 0
          season_tie[game.season] += 1
        end
      end
    end
  end

  def winning_seasons(season_wins, season_loss, season_tie, winning_seasons)
    season_wins.each_pair do |season, count|
      winning_seasons[season] = (count.to_f / (season_loss[season].to_f + season_tie[season].to_f + count.to_f)) * 100
    end
  end

  def calculate_goal_count(team_id, games, game_goal_count)
    games.each do |game|
      if game.away_team_id.to_s == team_id
        game_goal_count[game.game_id] = game.away_goals
      elsif game.home_team_id.to_s == team_id
        game_goal_count[game.game_id] = game.home_goals
      end
    end
  end

  def wins_against(wins, wins_against)
    wins.each do |row|
      @games.each do |game|
        if row.game_id == game.game_id
         wins_against[game.away_team_id] ||= 0
         wins_against[game.away_team_id] += 1
        end
      end
    end
  end

  def loss_against(loss, loss_against)
    loss.each do |row|
      @games.each do |game|
        if row.game_id == game.game_id
         loss_against[game.away_team_id] ||= 0
         loss_against[game.away_team_id] += 1
        end
      end
    end
  end



end
