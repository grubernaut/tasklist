class Report < ActiveRecord::Base
  scope :completed, -> { where("completed =?", true) }
  scope :active, -> { where("completed =?", false) }

end
