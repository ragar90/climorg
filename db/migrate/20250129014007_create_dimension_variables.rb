class CreateDimensionVariables < ActiveRecord::Migration
  def change
    create_table :dimension_variables do |t|
      t.string :name, comment: "Name of the variable"
      t.references :dimension, index: true, foreign_key: true, comment: "Dimension to which the variable belongs"

      t.timestamps null: false
    end
  end
end
