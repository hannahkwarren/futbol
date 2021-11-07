require_relative 'spec_helper'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:each) do
    @game_path = './data/games.csv'

    @filenames = {
      games: @game_path

    }
    @stat_tracker = StatTracker.from_csv(@filenames)
  end

  it 'can return the highest_total_score' do
    expect(@stat_tracker.highest_total_score).to eq(11)
  end

  it 'can return the highest_total_score' do
    expect(@stat_tracker.lowest_total_score).to eq(0)
  end

  it 'can return a percentage of home team wins' do
    expect(@stat_tracker.percentage_home_wins).to eq(43.502)
  end

  it 'can return a percentage of visitor team wins' do
    expect(@stat_tracker.percentage_visitor_wins).to eq(36.111)
  end

  it 'can return a count of games by season' do
    expect(@stat_tracker.count_of_games_by_season).to eq({ 20_122_013 => 806, 20_162_017 => 1317, 20_142_015 => 1319,
                                                           20_152_016 => 1321, 20_132_014 => 1323, 20_172_018 => 1355 })
  end

  it 'can return a percentage of games tied' do
    expect(@stat_tracker.percentage_ties).to eq(20.387)
  end
end
