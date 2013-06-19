class CreateResearches < ActiveRecord::Migration
  def change
    create_table :researches do |t|
      t.string :company_name
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
