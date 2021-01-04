class DrugsController < ApplicationController
   def destroy
      destroy_drug_or_condition(PatientDrug.find_by(drug_id: params[:id]))
   end
end
