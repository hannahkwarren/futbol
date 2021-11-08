require './lib/game_team'
require './lib/game'
require './lib/team'
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
    @season_child = SeasonChild.new(@filenames)
  end

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
  end

  it '#games_in_season' do
    games_in_season = @season_child.games_in_season"20122013"
    count = games_in_season.length
    expect(count).to eq(806)
  end

  it '#return_team_name' do
    expect(@season_child.return_team_name(6)).to eq("FC Dallas")
  end

  it '#winningest_coach' do
    expect(@stat_tracker.winningest_coach("20122013")).to eq("Dan Lacroix")
  end

  it "#worst_coach" do
    expect(@stat_tracker.worst_coach("20122013")).to eq("Martin Raymond")
  end

  it "#most_accurate_team" do
    expect(@stat_tracker.most_accurate_team("20122013")).to eq("DC United")
  end

  it "#least_accurate_team" do
    expect(@stat_tracker.least_accurate_team("20122013")).to eq("New York City FC")
  end

  it "#most_tackles" do
    expect(@stat_tracker.most_tackles("20122013")).to eq("FC Cincinnati")
  end

  it "#fewest_tackles" do
    expect(@stat_tracker.fewest_tackles("20122013")).to eq("Atlanta United")
  end

end
