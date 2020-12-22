class DrugsController < ApplicationController
   def destroy
      drug = PatientDrug.find_by(drug_id: params[:id])
      patient = Patient.find(drug.patient_id)
      drug.destroy
      redirect_to patient_path(patient)
   end
end
