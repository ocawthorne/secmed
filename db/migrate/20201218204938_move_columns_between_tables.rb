class MoveColumnsBetweenTables < ActiveRecord::Migration[6.0]
  def change
    add_column :patient_drugs, :prescription, :string
    add_column :patient_drugs, :prescription_expiry, :datetime
    remove_column :appointments, :prescription
    remove_column :appointments, :prescription_expiry
  end
end
