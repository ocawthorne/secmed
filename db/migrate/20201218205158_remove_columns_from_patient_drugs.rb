class RemoveColumnsFromPatientDrugs < ActiveRecord::Migration[6.0]
  def change
    remove_column :patient_drugs, :dosage
    remove_column :patient_drugs, :active
  end
end
