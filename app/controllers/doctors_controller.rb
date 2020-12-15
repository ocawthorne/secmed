class DoctorsController < ApplicationController
   def create
      Doctor.create(user_params)
   end

   private

   def user_params
      params.require(:doctor).permit(:email, :password, :password_confirmation)
   end

end
