class CreateTableDrugInteractions < ActiveRecord::Migration[6.0]
  def change
    create_table :drug_interactions do |t|
      t.integer :drug_1
      t.integer :drug_2
      t.text :info
    end
  end
end
