class ChangeOrgranizationToOrganization < ActiveRecord::Migration
  def up
  	rename_table :orgranizations, :organizations
  end
  def down
  	rename_table :organizations, :orgranizations
  end
end
