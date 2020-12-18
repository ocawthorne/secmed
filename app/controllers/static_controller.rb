class StaticController < ApplicationController
  def home
    if user_id_type == "patient_id"
      redirect_to patient_appointments_path(current_user)
    elsif user_id_type == "doctor_id"
      redirect_to doctor_appointments_path(current_user)
    end
  end
end
