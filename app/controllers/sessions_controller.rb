class SessionsController < ApplicationController
   def new

   end

   def create
      @doctor = Doctor.find_by(email: params[:email])
      return head(:forbidden) unless @doctor.authenticate(params[:password])
      session[:doctor_id] = @doctor.id
   end
end
