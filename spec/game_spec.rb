require_relative 'spec_helper'
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
  end

  it 'can return the highest_total_score' do
    expect(@stat_tracker.highest_total_score(@stat_tracker.games)).to eq(11)
  end

  it 'can return the highest_total_score' do
    expect(@stat_tracker.lowest_total_score(@stat_tracker.games)).to eq(0)
  end

  it 'can return a percentage of home team wins' do
    expect(@stat_tracker.percentage_home_wins(@stat_tracker.game_teams)).to eq(3237.0)
  end

  it 'can return a percentage of visitor team wins' do
    expect(@stat_tracker.percentage_visitor_wins(@stat_tracker.game_teams)).to eq(2687.0)
  end
end
