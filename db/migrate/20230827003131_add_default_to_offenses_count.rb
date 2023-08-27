class AddDefaultToOffensesCount < ActiveRecord::Migration[7.0]
  def change
    change_column_default :repository_checks, :offenses_count, 0
  end
end
