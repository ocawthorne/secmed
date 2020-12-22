class ConditionsController < ApplicationController
   def destroy
      condition = PatientCondition.find_by(condition_id: params[:id])
      patient = Patient.find(condition.patient_id)
      condition.destroy
      redirect_to patient_path(patient)
   end
end
