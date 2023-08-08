class RenameOwnerNameToFullNameInRepositories < ActiveRecord::Migration[7.0]
  def change
    rename_column :repositories, :owner_name, :full_name
  end
end
