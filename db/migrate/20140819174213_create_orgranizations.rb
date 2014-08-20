class CreateOrgranizations < ActiveRecord::Migration
  def change
    create_table :orgranizations do |t|
      t.string :name
      t.string :logo
      t.integer :country_id

      t.timestamps
    end
    remove_column :researches, :research_parent_id
    remove_column :researches, :correlative
    add_column :researches, :organization_id, :integer
  end
end
