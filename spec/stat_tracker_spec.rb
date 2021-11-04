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

  it 'exists' do
    expect(@stat_tracker).to be_an_instance_of(StatTracker)
    expect(StatTracker.from_csv(@filenames)).to be_an_instance_of(StatTracker)
  end

  it 'can access csv data' do
    expect(StatTracker.from_csv(@filenames)).to be_an_instance_of(StatTracker)
  end

  it '#team_info' do
    expect(@stat_tracker.team_info('LA Galaxy')).to eq({
      'team_id' => 17,
      'franchiseId' => 12,
      'teamName' => 'LA Galaxy',
      'abbreviation' => 'LA',
      'link' => '/api/v1/teams/17'
      })
  end

  it '#average_win_percentage' do
    expect(@stat_tracker.average_win_percentage(17)).to eq(57.14)
    #add another test for different team
  end


end
