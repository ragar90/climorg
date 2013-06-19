class CreateDemographicVariables < ActiveRecord::Migration
  def change
    create_table :demographic_variables do |t|
      t.string :name
      t.boolean :is_default
      t.string :display_values
      t.string :accepted_value
      t.timestamps
    end
  end
end
