class CreateResearchApplications < ActiveRecord::Migration
  def change
    create_table :research_applications do |t|
      t.integer :research_id
      t.date :starts_on
      t.date :ends_on
      t.integer :number

      t.timestamps
    end
  end
end
