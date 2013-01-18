class CreateDemographicTypes < ActiveRecord::Migration
  def change
    create_table :demographic_types do |t|
      t.string :name
      t.string :acsepted_values

      t.timestamps
    end
  end
end
