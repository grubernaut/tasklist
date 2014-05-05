namespace :app do

  desc 'Populate Bi-Annuals with data'
  task populate_biannuals: :environment do
    @biannuals = Biannual.all
    @biannuals.each do |active|
      if active.completed == false
        active.update_attribute :completed, true
        active.update_attribute :completed_by, 'NotClaimed'
      end
    end

    # INSERT THESE
    attributes =
    [
      { title: 'Gaseous Fire Suppr. Checked by Vendor', completed: false },
      { title: 'Test Emergency Lights and Exit Signs', completed: false },
      { title: 'PDUs Spot Checked', completed: false },
      { title: 'Load Test Cummins Generators', completed: false },
      { title: 'Logic Test Cummins Generators', completed: false },
      { title: 'Test Switchgear during Genset Logic Test', completed: false },
      { title: 'Visually Inspect Trane Chillers', completed: false },
      { title: 'Inspect and Test Water Sensors', completed: false }
    ]

    fail "Env Variable mismatch in rake task\napplication.yml!=biannuals.rake
    \n#{ENV['BIANNUAL_ITEMS']}!=#{attributes.length}" unless
      attributes.length == ENV['BIANNUAL_ITEMS'].to_i

    attributes.each do |attribute|
      Biannual.create(attribute)
    end

  end

  desc 'Clear Bi-Annuals from data'
  task clear_biannuals: :environment do
    @biannuals = Biannual.all
    @biannuals.each do |biannual|
      biannual.destroy
    end
  end
end
