class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :description
      t.boolean :is_default
      t.integer :dimension_id

      t.timestamps
    end
  end
end
