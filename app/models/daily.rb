class Daily < ActiveRecord::Base
  scope :completed, -> { where("completed =?", true) }
  scope :active, -> { where("completed =?", false) }

  def title=(title)
    write_attribute(:title, title.strip)
  end

  def complete
    #self.update(:completed,true)
    write_attribute(:completed, true)
  end
end
