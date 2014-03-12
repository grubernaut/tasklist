class CreateMonths < ActiveRecord::Migration
  def change
    create_table :months do |t|
      t.string :title
      t.string :completed_by
      t.boolean :completed

      t.timestamps
    end
  end
end
