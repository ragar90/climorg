class AddStateToResearches < ActiveRecord::Migration
  def change
    add_column :researches, :state, :boolean, :default => false
  end
end
