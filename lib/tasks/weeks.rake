namespace :app do

  desc "Populate Weeks with data"
  task :populate_weeks => :environment do

    #INSERT THESE
    [
      {:title => "AutoTask", :completed => false},
      {:title => "Auto2Task", :completed => false},
    ].each do |attributes|
      Week.create(attributes)
    end
  end

  desc "Alert Week"
  task :alert_weeks => :environment do
    #Week.alert
    @wactive = Week.active
    @mactive = Month.active
    @yactive = Year.active
    WeeksMailer.weekly_email(@wactive,@mactive,@yactive).deliver
  end
end
