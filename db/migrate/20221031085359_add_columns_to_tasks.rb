class AddColumnsToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :finish_on, :date, default: -> { 'NOW()' }, null: false
  end
end
