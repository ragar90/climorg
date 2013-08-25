class CreateReportFilters < ActiveRecord::Migration
  def change
    create_table :report_filters do |t|
      t.integer :report_id
      t.integer :research_id
      t.string :filtrable_type
      t.integer :filtrable_id
      t.string :filtrable_value
      t.string :demographic_type
      t.timestamps
    end
  end
end
