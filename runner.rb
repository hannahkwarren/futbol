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

# p stat_tracker.all_coaches
# p stat_tracker.game_teams[0].game_id


# puts stat_tracker.worst_coach

puts stat_tracker.most_tackles(20122013)

# puts stat_tracker.winningest_coach("20132014")

# puts stat_tracker.most_accurate_team("20132014")


# puts stat_tracker.worst_coach("20132014")
 # puts stat_tracker.worst_coach("20142015")



##### NEED TO FIX
# if a coach is winless - won't return for worst coach
# correct for ties - can lump in with losses

# return team names - not team id
