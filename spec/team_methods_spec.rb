require_relative 'spec_helper'
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:each) do
    @game_path = './data/games_test.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams_test.csv'

    @filenames = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@filenames)
  end


  it '#team_info' do
    expect(@stat_tracker.team_info(17)).to eq({
      'team_id' => 17,
      'franchise_id' => 12,
      'team_name' => 'LA Galaxy',
      'abbreviation' => 'LA',
      'link' => '/api/v1/teams/17'
      })
  end

  it '#average_win_percentage' do
    expect(@stat_tracker.average_win_percentage(17)).to eq(0.57)
  end
end
