desc 'Import data from the Reach Export .csv files'
task import_reach_voters: :environment do
  puts "starting"
  any_failed = ReachCsvLoader.new.load_voters
  puts "done! #{any_failed ? "encountered some errors" : "100% successful"}"
end
