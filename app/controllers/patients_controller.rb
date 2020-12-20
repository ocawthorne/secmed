class PatientsController < ApplicationController
   before_action :require_login
   before_action :must_be_doctor
   skip_before_action :must_be_doctor, only: :show

   def new
      @patient = Patient.new
   end

   def create
      @patient = Patient.create(params)
   end

   def show
      if user_id_type == "patient_id"
         return head(:forbidden) unless session[:patient_id] == params[:id].to_i
      end
      @patient = Patient.find(params[:id])
      @conditions = @patient.conditions.map { |c| c.name }
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
