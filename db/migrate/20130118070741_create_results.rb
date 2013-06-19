class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :research_id

      t.timestamps
    end
  end
end
