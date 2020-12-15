class AddColumnsToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :drugs, :contraurl, :string
    add_column :drugs, :interactionurl, :string
    add_column :drugs, :contraindications, :text
    add_column :patient_drugs, :active, :boolean
    add_column :appointments, :complaint, :text
    add_column :appointments, :diagnosis, :text
    add_column :appointments, :diagnosispending, :boolean
    add_column :appointments, :prescription, :string
    add_column :appointments, :prescriptionexpiry, :datetime
  end
end
