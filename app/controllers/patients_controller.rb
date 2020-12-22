class PatientsController < ApplicationController
   before_action :must_be_doctor_or_current_patient

   def show
      if user_id_type == "patient_id"
         return head(:forbidden) unless session[:patient_id] == params[:id].to_i
      end
      @patient = Patient.find(params[:id])
      @conditions = @patient.conditions
      active_drugs = @patient.drugs.active.select{ |drug| drug.patient_id == @patient.id }.sort
      @drug_interactions = find_drug_interactions(active_drugs)
      @drug_contraindications = find_drug_contraindications(active_drugs, @patient.conditions)
   end

   def index
      @patients = Patient.all.sort_by{ |patient| patient.surname }
   end

   def edit
      @patient = Patient.find(params[:id])
   end

   def update
      @patient = Patient.update(params)
   end

end
