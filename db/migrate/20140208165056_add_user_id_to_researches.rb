class AddUserIdToResearches < ActiveRecord::Migration
  def change
    add_column :researches, :user_id, :integer
  end
end
