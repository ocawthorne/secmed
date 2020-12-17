class ChangeColumnNamesInAppointments < ActiveRecord::Migration[6.0]
  def change
    rename_column :appointments, :diagnosispending, :diagnosis_pending
    rename_column :appointments, :prescriptionexpiry, :prescription_expiry
  end
end
