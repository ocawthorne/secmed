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
   end

   def index
      
   end

   def edit
      @patient = Patient.find(params[:id])
   end

   def update
      @patient = Patient.update(params)
   end

end
