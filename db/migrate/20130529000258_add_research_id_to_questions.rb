class AddResearchIdToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :research_id, :integer
  end
end
