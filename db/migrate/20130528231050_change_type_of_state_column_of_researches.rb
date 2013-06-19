class ChangeTypeOfStateColumnOfResearches < ActiveRecord::Migration
  def up
    remove_column :researches, :state
    add_column :researches, :state, :integer, :default=>0
  end
  
  def down
    remove_column :researches, :state
    add_column :researches, :state, :boolean, :default=>false
  end
end
