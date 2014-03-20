namespace :app do

  desc "Populate Days with data"
  task :populate_days => :environment do
    @days = Daily.all
    @days.each do |active|
      active.update_attribute :completed, true
      active.update_attribute :completed_by, "NotClaimed"
    end

    #INSERT THESE
    [
      {:title => "Inspect Generators", :completed => false},
      {:title => "Inspect Cooling Towers", :completed => false},
      {:title => "Inspect West Fence and West Gates", :completed => false},
      {:title => "Inspect West Side Drainage", :completed => false},
      {:title => "Inspect East and West Building AC Units for Office Area", :completed => false},
      {:title => "Check for Overall Leaks in Maintenance Areas", :completed => false},
      {:title => "Inspect all Breakers", :completed => false},
      {:title => "Inspect Switchgear", :completed => false},
      {:title => "Verify no Faults or Warnings on UPS Flywheels", :completed => false},
      {:title => "Verify no Faults or Warnings on Chillers", :completed => false},
      {:title => "Verify no Faults or Warnings on PDUs", :completed => false},
      {:title => "Change Water Filter in Cooling Towers", :completed => false},
    ].each do |attributes|
      Daily.create(attributes)
    end
  end

  desc "Alert Day"
  task :alert_dailies => :environment do
    #Week.alert
    @active = Daily.active
    DailyMailer.daily_email(@active).deliver
  end
end
