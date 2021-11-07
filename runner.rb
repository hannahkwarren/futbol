# runner.rb
 require './lib/stat_tracker'
 require 'csv'

 game_path = './data/games.csv'
 team_path = './data/teams.csv'
 game_teams_path = './data/game_teams.csv'

 filenames = {
   games: game_path,
   teams: team_path,
   game_teams: game_teams_path
 }

stat_tracker = StatTracker.from_csv(filenames)


puts stat_tracker.worst_coach("20122013")






##### NEED TO FIX
# if a coach is winless - won't return for worst coach
# correct for ties - can lump in with losses

# return team names - not team id
