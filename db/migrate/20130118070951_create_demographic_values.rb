class CreateDemographicValues < ActiveRecord::Migration
  def change
    create_table :demographic_values do |t|
      t.integer :demographi_variable_id
      t.string :result_id
      t.string :value

      t.timestamps
    end
  end
end
