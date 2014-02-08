class ChangeCompanyNameOnResearches < ActiveRecord::Migration
  def change
  	rename_column :researches, :company_name, :organization_name
  end
end
