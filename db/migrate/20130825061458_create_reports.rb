class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :legend
      t.integer :research_id
      t.string :chart_type

      t.timestamps
    end
  end
end
