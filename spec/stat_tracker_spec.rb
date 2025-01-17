require 'spec_helper'
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

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
    expect(StatTracker.from_csv(@filenames)).to be_an_instance_of(StatTracker)
  end

  it 'can access csv data' do
    expect(StatTracker.from_csv(@filenames)).to be_an_instance_of(StatTracker)
  end
end
