class SessionsController < ApplicationController

  def new
    redirect_to controller: 'appointments', action: 'index' if user_id_type
  end

  def create
    doctor, patient = Doctor.find_by(email: params[:email]), Patient.find_by(email: params[:email])
    doctor.try(:authenticate, params[:password]) if doctor
    patient.try(:authenticate, params[:password]) if patient
    if doctor
      session[:doctor_id] = doctor.id
    elsif patient
      session[:patient_id] = patient.id
    else
      redirect_to controller: 'sessions', action: 'new'
    end
    redirect_to controller: 'appointments', action: 'index'
  end 
  
  def destroy
    session.delete(:"#{user_id_type}")
    redirect_to root_path
  end
    
end
