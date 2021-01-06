class PatientsController < ApplicationController
   before_action :must_be_doctor_or_current_patient, except: [:new, :create]

   def new
      @patient = Patient.new
   end

   def create
      @patient = Patient.create(user_params)
      if @patient.errors.any?
         render 'new'
      else
         session[:patient_id] = @patient.id
         redirect_to patient_path(@patient)
      end
   end

   def show
      @patient = Patient.find(params[:id])
      active_drugs = Drug.active.select{ |drug| drug.patient_id == @patient.id }.sort
      @drug_interactions = find_drug_interactions(active_drugs)
      @drug_contraindications = find_drug_contraindications(active_drugs, @patient.conditions)
   end

   def index
      @patients = Patient.all.sort_by{ |patient| patient.surname }
   end
   
   private

   def user_params
      params.permit(:first_name, :middle_name, :surname, :date_of_birth, :email, :password, :password_confirmation)
   end
 
end
