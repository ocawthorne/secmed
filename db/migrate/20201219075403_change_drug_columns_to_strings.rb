class ChangeDrugColumnsToStrings < ActiveRecord::Migration[6.0]
  def change
    change_column :drug_interactions, :drug_1, :string
    change_column :drug_interactions, :drug_2, :string
  end
end
