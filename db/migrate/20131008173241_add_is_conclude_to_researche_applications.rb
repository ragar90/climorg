class AddIsConcludeToResearcheApplications < ActiveRecord::Migration
  def change
    add_column :research_applications, :is_conclude, :boolean, default: false
  end
end
