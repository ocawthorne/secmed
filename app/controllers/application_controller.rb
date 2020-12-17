class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception

   def user_id_type
      if session.to_h.has_key?("doctor_id")
         "doctor_id"
      elsif session.to_h.has_key?("patient_id")
         "patient_id"
      else
         nil
      end
   end

   def current_user
      Object.const_get(user_id_type.delete_suffix('_id').capitalize).find(session[:"#{user_id_type}"]) if logged_in?
   end

   def logged_in?
      !!user_id_type
   end

   private

   def require_login
      redirect_to(controller: 'sessions', action: 'new') unless logged_in?
   end

   def must_be_doctor
      return head(:forbidden) unless (session[:patient_id] == params[:id].to_i if session.to_h.has_key?(:patient_id)) || (user_id_type == "doctor_id")
   end

end
