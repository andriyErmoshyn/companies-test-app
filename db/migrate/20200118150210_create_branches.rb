class CreateBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :branches do |t|
      t.bigint     :number, null: false, index: { unique: true }
      t.string     :area
      t.references :company, foreign_key: { on_delete: :cascade }
    end
  end
end
