class AppointmentsController < ApplicationController
   before_action :require_login
   before_action :must_be_doctor
   skip_before_action :must_be_doctor, only: [:index, :show]

   def new
      @patients = Doctor.find(session[:doctor_id]).patients
   end

   def create
      
   end

   def index
      @user, @user_id_type = current_user, user_id_type
   end

   def show

   end

end
