class Condition < ActiveRecord::Base
   has_many :patient_conditions
   has_many :patients, through: :patient_conditions
end
