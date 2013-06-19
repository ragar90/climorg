class RenameDemographiVariableIdToDemographicVariableId < ActiveRecord::Migration
  def change
    rename_column :demographic_values, :demographi_variable_id, :demographic_variable_id
  end
end
