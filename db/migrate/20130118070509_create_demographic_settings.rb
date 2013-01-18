class CreateDemographicSettings < ActiveRecord::Migration
  def change
    create_table :demographic_settings do |t|
      t.integer :research_id
      t.integer :demographic_variable_id

      t.timestamps
    end
  end
end
