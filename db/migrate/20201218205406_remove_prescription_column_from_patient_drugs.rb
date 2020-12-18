class RemovePrescriptionColumnFromPatientDrugs < ActiveRecord::Migration[6.0]
  def change
    remove_column :patient_drugs, :prescription
  end
end
