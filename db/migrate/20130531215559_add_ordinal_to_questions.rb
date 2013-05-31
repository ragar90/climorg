class AddOrdinalToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :ordinal, :integer
  end
end
