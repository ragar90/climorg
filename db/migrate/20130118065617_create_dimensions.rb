class CreateDimensions < ActiveRecord::Migration
  def change
    create_table :dimensions do |t|
      t.string :name
      t.boolean :is_default

      t.timestamps
    end
  end
end
