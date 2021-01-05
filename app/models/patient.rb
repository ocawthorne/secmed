class Patient < ActiveRecord::Base
   has_many :appointments
   has_many :doctors, through: :appointments
   
   has_many :patient_drugs
   has_many :drugs, through: :patient_drugs

   has_many :patient_conditions
   has_many :conditions, through: :patient_conditions

   validates :first_name, presence: true
   validates :surname, presence: true
   validates :date_of_birth, presence: true
   validates :password, presence: true, length: { minimum: 6 }
   validates_confirmation_of :email, :password
   validates_confirmation_of :password

   has_secure_password
end
