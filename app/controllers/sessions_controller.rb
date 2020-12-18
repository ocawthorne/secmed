class SessionsController < ApplicationController

  def new
    redirect_to controller: 'appointments', action: 'index' if logged_in?
  end

  def create
    if auth
      user = Patient.find_or_create_by(uid: auth['uid']) do |u|
        u.first_name = auth['info']['name'].split(" ").first
        u.surname = auth['info']['name'].split(" ").last
        u.email = auth['info']['email']
        u.password = SecureRandom.hex
      end
      session[:patient_id] = user.id
    else
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
    end
    redirect_to controller: 'appointments', action: 'index'
  end 
  
  def destroy
    session.delete(:"#{user_id_type}")
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end
    
end
