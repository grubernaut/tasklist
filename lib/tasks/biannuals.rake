namespace :app do

  desc "Populate Bi-Annuals with data"
  task :populate_biannuals => :environment do
    @biannuals = Biannual.all
    @biannuals.each do |active|
      active.update_attribute :completed, true
      active.update_attribute :completed_by, "NotClaimed"
    end

    #INSERT THESE
    [
      {:title => "Gaseous Fire Suppression Checked by Vendor", :completed => false},
      {:title => "Test Emergency Lights and Exit Signs", :completed => false},
      {:title => "PDUs Spot Checked", :completed => false},
      {:title => "Load Test Cummins Generators", :completed => false},
      {:title => "Logic Test Cummins Generators", :completed => false},
      {:title => "Test Switchgear during Generator Logic Test", :completed => false},
      {:title => "Visually Inspect Trane Chillers", :completed => false},
      {:title => "Inspect and Test Water Sensors", :completed => false},
    ].each do |attributes|
      Biannual.create(attributes)
    end
  end
end
