=begin
desc 'Import up-to-date voter data from a CSV'
task import_voters: :environment do
  puts "starting"
  any_failed = BigQueryLoader.new.load_voters
  puts "done! #{any_failed ? "encountered some errors" : "100% successful"}"
end

desc 'Import up-to-date user data from BQ'
task import_users: :environment do
  puts "starting"
  any_failed = BigQueryLoader.new.load_users
  puts "done! #{any_failed ? "encountered some errors" : "100% successful"}"
end

desc 'Import up-to-date relationship data from BQ'
task import_relationships: :environment do
  puts "starting"
  any_failed = BigQueryLoader.new.load_relationships
  puts "done! #{any_failed ? "encountered some errors" : "100% successful"}"
end
=end
