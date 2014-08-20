class RemoveResearchApplicationIdFromResults < ActiveRecord::Migration
  def change
  	remove_column :results,:research_application_id
  end
end
