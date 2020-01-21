class UpdateBranchesIndexes < ActiveRecord::Migration[5.2]
  def change
    remove_index :branches, :number
    add_index :branches, [:number, :company_id], unique: true
  end
end
