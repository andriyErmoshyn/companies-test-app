class AddArchivedToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :archived, :boolean, default: false
  end
end
