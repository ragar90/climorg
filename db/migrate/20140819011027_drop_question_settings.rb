class DropQuestionSettings < ActiveRecord::Migration
  def up
  	drop_table :question_settings
  end

  def down
  	create_table :question_settings do |t|
      t.integer :research_id
      t.integer :question_id

      t.timestamps
    end
  end
end
