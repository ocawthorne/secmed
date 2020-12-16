class AppointmentsController < ApplicationController
   def new
      @patients = Doctor.find(session[:id]).patients
   end

   def create

   end
end
