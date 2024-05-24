class AddColumnActiveToJobs < ActiveRecord::Migration[6.0]
  def change
    add_column :jobs, :active, :boolean, default: true
  end
end
