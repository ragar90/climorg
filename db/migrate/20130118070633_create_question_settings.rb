class CreateQuestionSettings < ActiveRecord::Migration
  def change
    create_table :question_settings do |t|
      t.integer :research_id
      t.integer :question_id

      t.timestamps
    end
  end
end
