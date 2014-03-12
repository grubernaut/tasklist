namespace :app do

  desc "Populate Months with data"
  task :populate_months => :environment do

    #INSERT THESE
    [
      {:title => "AutoMonthTask"},
      {:title => "Auto2MonthTask"},
    ].each do |attributes|
      Month.create(attributes)
    end
  end
end
