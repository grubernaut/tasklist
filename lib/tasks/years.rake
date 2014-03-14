namespace :app do

  desc "Populate Years with data"
  task :populate_years => :environment do

    #INSERT THESE
    [
      {:title => "AutoYearTask", :completed => false},
      {:title => "Auto2YearTask", :completed => false},
    ].each do |attributes|
      Year.create(attributes)
    end
  end
end
