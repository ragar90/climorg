class RemoveOrganizationNameFromResearches < ActiveRecord::Migration
  def change
    remove_column :researches, :organization_name, :string
  end
end
