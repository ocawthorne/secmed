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
      drug = Drug.find_by(name: params[:drugs])
      patient.drugs << drug
      PatientDrug.find_by(patient_id: patient.id, drug_id: drug.id).update(prescription_expiry: params[:prescription_expiry])
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
      active_drugs = patient.drugs.active.map{ |d| Drug.find(d.drug_id) }.sort_by{ |d| d.name }
      max = active_drugs.count
      #? If the total number of active drugs taken exceeds 1.
      if max > 1
         #? Then, for each active drug with an index number, do:
         active_drugs.each_with_index do |drug, i|
            #? If there are four object, A, B, C, and D, which search for pairings between each other,
            #? then [A ~ B, C, D], [B ~ C, D], [C ~ D]. There are no other searches necessary.
            next if i == max - 1
            n = 1
            until i + n == max
               #? i starts at 0 for each drug, and n starts at one greater than the drug's index
               #? so that it searches for the next drug in the list, the one after that, until
               #? i + n = max (e.g. max = 3, i.e. drug[0], drug[1], drug[2])
               int = DrugInteraction.where("drug_1 = ? and drug_2 = ?", drug.name, active_drugs[i+n].name)
               @drug_interactions << int unless int.empty?
               n += 1
            end
         end
      end

   end

   def destroy
      Appointment.find(params[:id]).destroy
   end

end
