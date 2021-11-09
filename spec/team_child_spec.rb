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
    @team_child = TeamChild.new(@filenames)
  end


  it '#team_info' do
    expect(@stat_tracker.team_info("17")).to eq({
      'team_id' => "17",
      'franchise_id' => "12",
      'team_name' => 'LA Galaxy',
      'abbreviation' => 'LA',
      'link' => '/api/v1/teams/17'
      })
  end

  it '#best_season' do
    expect(@stat_tracker.best_season("4")).to eq("20132014")
  end

  it '#worst_season' do
    expect(@stat_tracker.worst_season("4")).to eq("20162017")
  end

  it '#average_win_percentage' do
    expect(@stat_tracker.average_win_percentage("17")).to eq(0.38)
  end

  it '#most_goals_scored' do
    expect(@stat_tracker.most_goals_scored("4")).to eq(6)
  end

  it '#fewest_goals_scored' do
    expect(@stat_tracker.fewest_goals_scored("4")).to eq(0)
  end

  it '#favorite_opponent' do
    expect(@stat_tracker.favorite_opponent("17")).to eq("Atlanta United")
  end

  it '#rival' do
    expect(@stat_tracker.rival("17")).to eq("Reign FC")
  end

  it '#choose_games' do
    expect(@team_child.choose_games("6", []).count).to eq(510)
  end

  it '#choose_game_teams' do
    expect(@team_child.choose_game_teams("4", []).count).to eq(477)
  end

  it '#separate_wins_loss_tie' do
    game_teams = [GameTeam.new(@filenames[:game_teams][5])]
    wins = []
    loss = []
    tie = []
    expect(@team_child.separate_wins_loss_tie(wins, loss, tie, game_teams)).to eq(game_teams)
  end

  it '#season_wins' do
    wins = [GameTeam.new(@filenames[:game_teams])]
    season_wins = {}
    expect(@team_child.season_wins(wins, season_wins)).to eq(wins)
  end

  it '#season_loss' do
    loss = [GameTeam.new(@filenames[:game_teams])]
    season_loss = {}
    expect(@team_child.season_loss(loss, season_loss)).to eq(loss)
  end

  it '#season_tie' do
    tie = [GameTeam.new(@filenames[:game_teams])]
    season_tie = {}
    expect(@team_child.season_tie(tie, season_tie)).to eq(tie)
  end

  it '#winning_seasons' do
    season_wins = {"20122013" => 0.45}
    expect(@team_child.winning_seasons(season_wins, {}, {}, {})).to eq(season_wins)
  end

  it '#calculate_goal_count' do
    games = [Game.new(@filenames[:games])]

    expect(@team_child.calculate_goal_count("14", games, {})).to eq(games)
  end

  it '#wins_against' do
    wins = [Game.new(@filenames[:games])]
    wins_against = {}

    expect(@team_child.wins_against(wins, wins_against)).to eq(wins)
  end

  it '#loss_against' do
    loss = [Game.new(@filenames[:games])]
    loss_against = {}

    expect(@team_child.loss_against(loss, loss_against)).to eq(loss)
  end

end
