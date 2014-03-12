namespace :app do

  desc "Populate Weeks with data"
  task :populate_weeks => :environment do

    #INSERT THESE
    [
      {:title => "AutoTask"},
      {:title => "Auto2Task"},
    ].each do |attributes|
      Week.create(attributes)
    end
  end
end
