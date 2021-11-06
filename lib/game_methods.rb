module GameMethods
  def total_score
    games.map do |game|
      game.away_goals + game.home_goals
    end
  end

  def lowest_total_score(_game)
    total_score.min
  end

  def highest_total_score(_game)
    total_score.max
  end

  def percentage_home_wins(_game_teams)
    home_wins.count.to_f
  end

  def home_wins
    game_teams.find_all do |game|
      game.HoA == 'home' && game.result == 'WIN'
    end
  end
  # def won?
  #   home_goals > away_goals
  # end
  #
  # def count_of_games_by_season; end
  #
  # def count_of_teams; end
end
