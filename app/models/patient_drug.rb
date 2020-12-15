class PatientDrug < ActiveRecord::Base
   belongs_to :patient
   belongs_to :drug
end
