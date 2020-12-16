class SessionsController < ApplicationController
   skip_before_action :verified_doctor, only: [:new, :create]

   def new; end

   def create
      doctor = Doctor.find_by(email: params[:email])
      doctor.try(:authenticate, params[:password])
      return redirect_to(controller: 'sessions', action: 'new') unless doctor
      session[:id] = doctor.id
      @doctor = doctor
      redirect_to controller: 'appointments', action: 'index'
    end
  
    def destroy
      session.delete("doctor_id")
      redirect_to root_path
    end
    
end
