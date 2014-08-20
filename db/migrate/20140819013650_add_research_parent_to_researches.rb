class AddResearchParentToResearches < ActiveRecord::Migration
  def change
    add_column :researches, :research_parent_id, :integer
    add_column :researches, :correlative, :integer
  end
end
