module ApplicationHelper
   def full_name(instance)
      "#{instance.first_name} #{instance.middle_name if instance.has_attribute?(:middle_name)} #{instance.surname}".squish
   end

   def logged_in?
      session.to_h.has_key?('patient_id') || session.to_h.has_key?('doctor_id')
   end
end
