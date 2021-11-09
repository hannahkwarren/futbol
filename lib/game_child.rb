require_relative './futbol_data'
class GameChild < FutbolData
  def initialize(filenames)
    super(filenames)
  end

  def total_score
    @games.map do |game|
      game.away_goals + game.home_goals
    end
  end

  def lowest_total_score
    total_score.min
  end

  def highest_total_score
    total_score.max
  end

  def percentage_home_wins
    (home_wins.count.to_f / games.count).round(2)
  end

  def home_wins
    games.find_all do |game|
      game.home_goals > game.away_goals
    end
  end

  def visitor_wins
    games.find_all do |game|
      game.home_goals < game.away_goals
    end
  end

  def percentage_visitor_wins
    (visitor_wins.count.to_f / games.count).round(2)
  end

  def count_of_games_by_season
    seasons = games.map do |game|
      game.season
    end.uniq!

    output = {}
    seasons.each do |season|
      output[season] =
        games.count do |game|
          game.season == season
        end
    end
    output
  end

  def tie
    games.find_all do |game|
      game.home_goals == game.away_goals
    end
  end

  def percentage_ties
    (tie.count.to_f / games.count * 100).round(3)
  end

  def average_goals_per_game
    sums = games.map do |game|
      game.away_goals + game.home_goals
    end
    (sums.count.to_f / games.count.to_f).round(3)
  end

  def average_goals_by_season
    seasons = games.map do |game|
      game.season
    end.uniq!

    output = {}
    seasons.each do |season|
      sums = games.map do |game|
        game.away_goals + game.home_goals
      end
      output[season] =
        (sums.count.to_f / games.count.to_f).round(3)
    end
    output
  end
end
