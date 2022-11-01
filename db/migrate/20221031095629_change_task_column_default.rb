class ChangeTaskColumnDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :finish_on, nil
  end
end
