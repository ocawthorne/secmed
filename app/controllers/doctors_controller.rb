class DoctorsController < ApplicationController
   before_action :require_login

   private

   def user_params
      params.require(:doctor).permit(:email, :password, :password_confirmation)
   end

end
