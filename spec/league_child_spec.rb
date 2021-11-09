require_relative 'spec_helper'
require './lib/futbol_data'
require './lib/stat_tracker'
require './lib/league_child'

RSpec.describe LeagueChild do
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
    @league_child = LeagueChild.new(@filenames)
  end

  it 'can return count of teams' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  it 'can #calc_average_goals_alltime' do
    expect(@league_child.calc_avg_goals_alltime(4, nil)).to eq(2.0377358490566038)
  end

  it 'can return team name of team with the best offense' do
    expect(@stat_tracker.best_offense).to eq("Reign FC")
  end

  it 'can return team name of team with the worst offense' do
    expect(@stat_tracker.worst_offense).to eq("Utah Royals FC")
  end

  it 'can return the average all-time goals when playing away or home' do
    expect(@league_child.calc_avg_goals_alltime(6, "home")).to eq(2.280155642023346)
    expect(@league_child.calc_avg_goals_alltime(54, "away")).to eq(2.0980392156862746)
  end

  it 'can return team name of team with highest all-time average score when playing away' do
    expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
  end

  it 'can return team name of team with highest all-time average score when playing at home' do
    expect(@stat_tracker.highest_scoring_home_team).to eq("Reign FC")
  end

  it 'can return team name of team with lowest all-time average score when playing away' do
    expect(@stat_tracker.lowest_scoring_visitor).to eq("San Jose Earthquakes")
  end

  it 'can return team name of team with lowest all-time average score when playing at home' do
    expect(@stat_tracker.lowest_scoring_home_team).to eq("Utah Royals FC")
  end

end
