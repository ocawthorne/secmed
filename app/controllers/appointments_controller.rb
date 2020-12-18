class AppointmentsController < ApplicationController
   before_action :require_login
   before_action :must_be_doctor
   skip_before_action :must_be_doctor, only: [:index, :show]

   def new
      @patients = Patient.all
      @drugs = Drug.all
   end

   def create
      name_split = params[:name].split(" ")
      first_name = name_split[0]
      surname = name_split[-1]
      patient = Patient.find_by(first_name: first_name, surname: surname)
      Appointment.create({
         date: params[:date],
         doctor_id: params[:id],
         patient_id: patient.id,
         complaint: params[:complaint],
         diagnosis: params[:diagnosis]
      })
      patient.drugs << Drug.find_by(name: params[:drug_name])
      PatientDrug.create({
         patient_id: patient.id,
         drug_id: Drug.find_by(name: params[:drug_name])
      })
      patient.conditions << Condition.find_or_create_by(name: params[:diagnosis])
   end

   def index
      @user, @user_id_type = current_user, user_id_type
   end

   def show
      @patient = Patient.find(params[:id])
      @appointment = Appointment.find(params[:appointment_id])
   end

end
