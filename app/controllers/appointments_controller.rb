require_relative '../../config/environment'

class AppointmentsController < ApplicationController
   before_action :require_login
   before_action :must_be_doctor
   skip_before_action :must_be_doctor, only: [:index, :show]

   def new
      @patients = Patient.all
      @drugs = Drug.all
   end

   def create
      patient = Patient.find(params[:patients].split(" ")[-1].to_i)
      appointment = Appointment.create(
         date: params[:date],
         doctor_id: params[:doctor_id],
         patient_id: patient.id,
         drug_prescribed: params[:drugs],
         complaint: params[:complaint],
         diagnosis: params[:diagnosis]
      )
      patient.drugs << Drug.find_by(name: params[:drugs])
      PatientDrug.create(
         patient_id: patient.id,
         drug_id: Drug.find_by(name: params[:drugs]),
         prescription_expiry: params[:prescription_expiry]
      )
      patient.conditions << Condition.find_or_create_by(name: params[:diagnosis])
      redirect_to patient_appointment_path(patient, appointment)
   end

   def index
      @user, @user_id_type = current_user, user_id_type
   end

   def show
      @appointment = Appointment.find(params[:id])
      @drug_interactions = []
      patient = @appointment.patient
      active_drugs = patient.drugs.active.sort_by{ |drug| drug.name }
      max = active_drugs.count
      binding.pry
      if max >= 2
         active_drugs.each_with_index do |drug, i|
            n = 1
            until i + n == max
               int = DrugInteraction.where("drug_1 = ? and drug_2 = ?", drug.name, active_drugs.to_a[i+n])
               @drug_interactions << int unless !int
               n += 1
            end
         end
      end
   end

end
