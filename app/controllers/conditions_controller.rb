class ConditionsController < ApplicationController
   # def index
   #    @conditions = Patient.find(params[:patient_id]).conditions
   # end
   
   def destroy
      destroy_drug_or_condition(PatientCondition.find_by(condition_id: params[:id]))
   end
end
