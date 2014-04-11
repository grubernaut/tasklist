namespace :app do

  desc "Populate Years with data"
  task :populate_years => :environment do
    @years = Year.all
    @years.each do |active|
      if active.completed == false
        active.update_attribute :completed, true
        active.update_attribute :completed_by, "NotClaimed"
      end
    end

    #INSERT THESE
    [
      {:title => "Change Filters in Liebert CRAC Units", :completed => false},
      {:title => "Fire Extinguishers Inspected by Vendor", :completed => false},
      {:title => "Test Emergency Lights", :completed => false},
      {:title => "Active Power UPS Flywheels Checked by Vendor", :completed => false},
      {:title => "Check Trane Chiller Oil and Take Sample", :completed => false},
      {:title => "Replace Cummins Generator Fuel", :completed => false},
      {:title => "Check Connections on Switchgear", :completed => false},
      {:title => "Take AMP Reading of the Well Motors", :completed => false},
      {:title => "Check Connections on the PDUs", :completed => false},
      {:title => "Vendor Checked Gaseous Fire Suppression", :completed => false},
    ].each do |attributes|
      Year.create(attributes)
    end
  end
end
