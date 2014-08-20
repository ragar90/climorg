class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :research_id
      t.integer :employee_id
      t.boolean :done, default: false
      t.integer :result_id

      t.timestamps
    end
    add_column :results, :evaluation_id, :integer
  end
end
