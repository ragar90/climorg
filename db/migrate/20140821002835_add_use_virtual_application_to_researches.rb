class AddUseVirtualApplicationToResearches < ActiveRecord::Migration
  def change
    add_column :researches, :use_virtual_application, :boolean, default: true
  end
end
