desc 'Import data from the PA SOS .tsv files'
task import_pa_voters: :environment do
  puts "starting"
  any_failed = PaSosLoader.new.load_voters
  puts "done! #{any_failed ? "encountered some errors" : "100% successful"}"
end
