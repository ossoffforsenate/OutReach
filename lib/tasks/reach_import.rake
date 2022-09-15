desc 'Import data from the Reach Export .csv files'
task import_reach_voters: :environment do
  puts "starting"
  any_failed = ReachCsvLoader.new.load_voters
  puts "done! #{any_failed ? "encountered some errors" : "100% successful"}"
end

desc 'Import data from the Reach Export .csv files'
task import_reach_users: :environment do
  puts "starting"
  any_failed = ReachCsvLoader.new.load_users
  puts "done! #{any_failed ? "encountered some errors" : "100% successful"}"
end

desc 'Import data from the Reach Export .csv files'
task import_reach_relationships: :environment do
  puts "starting"
  any_failed = ReachCsvLoader.new.load_relationships
  puts "done! #{any_failed ? "encountered some errors" : "100% successful"}"
end
