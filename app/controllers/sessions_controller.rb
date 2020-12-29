class SessionsController < ApplicationController

  def new
    if logged_in?
      redirect_to(user_id_type == "doctor_id" ? doctor_appointments_path(current_user) : patient_appointments_path(current_user))
    end
  end

  def create
    if auth
      user = Patient.find_or_create_y(uid: auth['uid']) do |u|
        u.first_name = auth['info']['name'].split(" ").first
        u.surname = auth['info']['name'].split(" ").last
        u.email = auth['info']['email']
        u.password = SecureRandom.hex
      end
      session[:patient_id] = user.id
    else
      @user = Doctor.find_by(email: params[:email])
      id_type = "doctor"
      unless @user 
        @user = Patient.find_by(email: params[:email])
        id_type = "patient"
      end
      if @user.try(:authenticate, params[:password])
        session[:"#{id_type}_id"] = @user.id
      else
        redirect_to login_path
      end
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
