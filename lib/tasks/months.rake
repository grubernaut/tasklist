namespace :app do

  desc "Populate Months with data"
  task :populate_months => :environment do
    @months = Month.all
    @months.each do |active|
      if active.completed == false
        active.update_attribute :completed, true
        active.update_attribute :completed_by, "NotClaimed"
      end
    end

    #INSERT THESE
    attributes = 
    [
      {:title => "Inspect and Grease Cooling Towers", :completed => false},
      {:title => "Inspect and Grease Water Pumps", :completed => false},
      {:title => "Inspect and Grease Liebert CRAC Units", :completed => false},
      {:title => "Spot Check inside of Liebert CRAC Units + Filter Check", :completed => false},
      {:title => "Check Gaseous Fire Suppression", :completed => false},
      {:title => "Check Salt in Brine Tanks", :completed => false},
      {:title => "Check Fire Extinguishers", :completed => false},
    ]

    raise "Env Variable mismatch in rake task\napplication.yml!=months.rake\n#{ENV["MONTHLY_ITEMS"]}!=#{attributes.length}" unless attributes.length == ENV["MONTHLY_ITEMS"].to_i
    
    attributes.each do |attribute|
      Month.create(attribute)
    end
  end

  desc "Clear Months from data"
  task :clear_months => :environment do
    @months = Month.all
    @months.each do |month|
      month.destroy
    end
  end
end
