class AddApplicationIdToResults < ActiveRecord::Migration
  def change
    add_column :results, :research_application_id, :integer
  end
end
