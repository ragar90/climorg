class DropResearchApplications < ActiveRecord::Migration
  def up
  	drop_table :research_applications
  end
  def down
  	create_table :research_applications do |t|
      t.integer :research_id
      t.date :starts_on
      t.date :ends_on
      t.integer :number

      t.timestamps
    end
  end
end
