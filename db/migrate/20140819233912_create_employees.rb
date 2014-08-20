class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.string :access_token
      t.boolean :has_evaluated_research, default: false
      t.integer :organization_id

      t.timestamps
    end
  end
end
