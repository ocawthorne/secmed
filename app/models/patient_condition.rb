class PatientCondition < ActiveRecord::Base
   belongs_to :patient
   belongs_to :condition
end
