class StaticController < ApplicationController

  def home
    case user_id_type
    when "patient_id"
      redirect_to patient_appointments_path(current_user)
    when "doctor_id"
      redirect_to doctor_appointments_path(current_user)
    end
  end
  
end
