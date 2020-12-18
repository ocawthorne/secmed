module ApplicationHelper
   def full_name(instance)
      "#{instance.first_name} #{instance.middle_name.to_s if instance.has_attribute?(:middle_name)} #{instance.surname}"
   end

   def logged_in?
      session.to_h.has_key?('patient_id') || session.to_h.has_key?('doctor_id')
   end
end
