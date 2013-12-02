class AddIsConcludeToResearches < ActiveRecord::Migration
  def change
    add_column :researches, :is_conclude, :boolean, default: false
  end
end
