module ApplicationHelper
   def full_name(instance)
      "#{instance.first_name} #{instance.middle_name if instance.has_attribute?(:middle_name)} #{instance.surname}".squish
   end

   def logged_in?
      !!user_id_type
   end

   def user_id_type
      if session.to_h.has_key?('patient_id')
         "patient_id"
      elsif session.to_h.has_key?('doctor_id')
         "doctor_id"
      else
         nil
      end
   end
end
