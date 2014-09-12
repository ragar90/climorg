class AddAccessTokenToEvaluations < ActiveRecord::Migration
  def up
    add_column :evaluations, :access_token, :string
    add_column :evaluations, :access_sent, :date
    remove_column :employees, :access_token
  end

  def down
    remove_column :evaluations, :access_token
    remove_column :evaluations, :access_sent
    add_column :employees, :access_token, :string
  end
end
