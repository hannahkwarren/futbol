require_relative 'spec_helper'
require './lib/game_child'
require './lib/futbol_data'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:each) do
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @filenames = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@filenames)
    @game_child = GameChild.new(@filenames)
  end

  it 'can return the highest_total_score' do
    expect(@stat_tracker.highest_total_score).to eq(11)
  end

  it 'can return the lowest_total_score' do
    expect(@stat_tracker.lowest_total_score).to eq(0)
  end

  it 'can return a percentage of home team wins' do
    expect(@stat_tracker.percentage_home_wins).to eq(0.44)
  end

  it 'can return a percentage of visitor team wins' do
    expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
  end

  it 'can return a count of games by season' do
    expect(@stat_tracker.count_of_games_by_season).to eq({ "20122013" => 806, "20162017" => 1317, "20142015" => 1319,
                                                           "20152016" => 1321, "20132014" => 1323, "20172018" => 1355 })
  end

  it 'can return a percentage of games tied' do
    expect(@stat_tracker.percentage_ties).to eq(0.2)
  end

  it 'can return the average goals of a game' do
    expect(@stat_tracker.average_goals_per_game).to eq(4.22)
  end


  it 'can return the average goals by season' do
    expect(@stat_tracker.average_goals_by_season).to eq({"20122013"=>4.12, "20162017"=>4.23, "20142015"=>4.14, "20152016"=>4.16, "20132014"=>4.19, "20172018"=>4.44})
  end
  
  
  it 'can give back a total score' do
    expect(@game_child.total_score.first(10)).to eq([5, 5, 3, 5, 4, 3, 5, 3, 1, 3])
  end

  it 'determines if it is a home win' do
    expect(@game_child.home_wins[0].game_id).to eq(2_012_030_221)
  end

  it 'determines if it is a visitor win' do
    expect(@game_child.visitor_wins[0].game_id).to eq(2_012_030_223)
  end

  it 'shows what games had a tie' do
    expect(@game_child.tie[0].game_id).to eq(2_012_030_121)
  end
end
