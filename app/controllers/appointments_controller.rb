class AppointmentsController < ApplicationController
   before_action :must_be_doctor_or_current_patient

   def new
      @appointment = Appointment.new
      @patients, @drugs = Patient.all, Drug.all
   end

   def create
      begin
         patient = Patient.find(params[:patients].split(" ")[-1].to_i)
      rescue ActiveRecord::RecordNotFound
      end
      @appointment = Appointment.create(
         date: params[:date],
         doctor_id: params[:doctor_id],
         patient_id: (patient.id if patient),
         drug_prescribed: params[:drugs],
         complaint: params[:complaint],
         diagnosis: params[:diagnosis]
      )
      if @appointment.errors.any?
         @patients, @drugs = Patient.all, Drug.all
         render 'new'
      else
         if !params[:drugs].empty?
            drug = Drug.find_by(name: params[:drugs])
            patient.drugs << drug
            PatientDrug.find_by(patient_id: patient.id, drug_id: drug.id).update(prescription_expiry: params[:prescription_expiry])
         end
         patient.conditions << Condition.find_or_create_by(name: params[:diagnosis].downcase.squish)
         redirect_to patient_appointment_path(patient, @appointment)
      end
   end

   def index
      @user, @user_id_type = current_user, user_id_type
   end

   def show
      @appointment = Appointment.find(params[:id])
      patient = @appointment.patient
      active_drugs = patient.drugs.active.select{ |drug| drug.patient_id == patient.id }
      @drug_interactions = active_drugs.count > 1 ? find_drug_interactions(active_drugs) : nil
      if @drug_interactions
         if @appointment.drug_prescribed == @drug_interactions[0][0].drug_1 || @appointment.drug_prescribed == @drug_interactions[0][0].drug_2
            @drug_interactions = @drug_interactions.count
         else
            @drug_interactions = nil
         end
      end
      drug_contraindications = find_drug_contraindications(active_drugs, patient.conditions)
      @dc = 0
      drug_contraindications.each do |c|
         c.include?(@appointment.drug_prescribed.upcase) ? @dc += 1 : nil
      end
   end

   def destroy
      a = Appointment.find(params[:id])
   end

end
