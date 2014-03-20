namespace :app do

  desc "Populate Weeks with data"
  task :populate_weeks => :environment do

    #INSERT THESE
    [
      {:title => "Start Test Cummins Generators", :completed => false},
      {:title => "Inspect interior of Cummins Generators", :completed => false},
      {:title => "Check Water Quality in the Wells", :completed => false},
      {:title => "Check Salt in Brine Tanks", :completed => false},
    ].each do |attributes|
      Week.create(attributes)
    end
  end

  desc "Alert Week"
  task :alert_weeks => :environment do
    #Week.alert
    @wactive = Week.active
    @mactive = Month.active
    @bactive = Biannual.active
    @yactive = Year.active
    WeeksMailer.weekly_email(@wactive,@mactive,@bactive,@yactive).deliver
  end
end
