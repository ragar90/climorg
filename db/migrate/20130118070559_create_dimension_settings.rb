class CreateDimensionSettings < ActiveRecord::Migration
  def change
    create_table :dimension_settings do |t|
      t.integer :research_id
      t.integer :dimension_id

      t.timestamps
    end
  end
end
