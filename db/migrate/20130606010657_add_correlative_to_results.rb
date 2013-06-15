class AddCorrelativeToResults < ActiveRecord::Migration
  def change
    add_column :results, :correlative, :integer
  end
end
