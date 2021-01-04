class ConditionsController < ApplicationController
   def destroy
      destroy_drug_or_condition(PatientCondition.find_by(condition_id: params[:id]))
   end
end
