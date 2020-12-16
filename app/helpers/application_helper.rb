module ApplicationHelper
   def full_name(instance)
      "#{instance.first_name}#{" "+instance.middle_name if instance.has_attribute?(:middle_name)} #{instance.surname}"
   end
end
