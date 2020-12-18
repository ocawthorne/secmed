class Drug < ActiveRecord::Base
   has_many :patient_drugs
   has_many :patients, through: :patient_drugs

   scope :active, -> {
      PatientDrug.where("prescription_expiry > ?", Time.now)
   }

end

# where("prescription_expiry < ?", Time.now)
