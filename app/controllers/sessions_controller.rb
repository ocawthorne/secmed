class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to(user_id_type == "doctor_id" ? doctor_appointments_path(current_user) : patient_appointments_path(current_user))
    end
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
      @doctor = Doctor.find_by(email: params[:email])
      @doctor.try(:authenticate, params[:password]) ? (session[:doctor_id] = @doctor.id) : (binding.pry ; qredirect_to login_path)
    end
    new
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
