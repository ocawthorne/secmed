class AddDrugPrescribedColumnToAppointments < ActiveRecord::Migration[6.0]
  def change
    add_column :appointments, :drug_prescribed, :string
  end
end
