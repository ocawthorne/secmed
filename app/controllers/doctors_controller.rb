class DoctorsController < ApplicationController
   def new

   end
   
   def create
      Doctor.create(user_params)
   end

   def show
      @doctor = Doctor.find(params[:id])
   end

   private

   def user_params
      params.require(:doctor).permit(:email, :password, :password_confirmation)
   end

end
