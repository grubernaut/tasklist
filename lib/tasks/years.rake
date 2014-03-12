namespace :app do

  desc "Populate Years with data"
  task :populate_years => :environment do

    #INSERT THESE
    [
      {:title => "AutoYearTask"},
      {:title => "Auto2YearTask"},
    ].each do |attributes|
      Year.create(attributes)
    end
  end
end
