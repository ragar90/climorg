class AddUserIdToDimenssionsAndVariables < ActiveRecord::Migration
  def change
    add_column :dimensions, :user_id, :integer
    add_column :dimensions, :is_active, :boolean,default: true
    add_column :demographic_variables, :user_id, :integer
    add_column :demographic_variables, :is_active, :boolean,default: true
  end
end
