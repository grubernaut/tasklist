namespace :app do

  desc "Populate Months with data"
  task :populate_months => :environment do

    #INSERT THESE
    [
      {:title => "AutoMonthTask", :completed => false},
      {:title => "Auto2MonthTask", :completed => false},
    ].each do |attributes|
      Month.create(attributes)
    end
  end
end
