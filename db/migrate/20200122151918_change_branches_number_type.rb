class ChangeBranchesNumberType < ActiveRecord::Migration[5.2]
  def change
    change_column :branches, :number, :string
  end
end
