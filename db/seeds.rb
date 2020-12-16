# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Doctor.create([
   {
      first_name: "Adam",
      surname: "Botticelli",
      email: "ab@doctor.com",
      password: "ab"
   },
   {
      first_name: "Charles",
      surname: "Darwin",
      email: "cd@doctor.com",
      password: "cd"
   },
   {
      first_name: "Erwin",
      surname: "Foxhill",
      email: "ef@doctor.com",
      password: "ef"
   }
])

Patient.create([
   {
      first_name: "Arnold",
      middle_name: "Bernard",
      surname: "Clark"
   },
   {
      first_name: "Diane",
      middle_name: "Eleanor",
      surname: "Florence"
   },
   {
      first_name: "Georgia",
      middle_name: "Harriet",
      surname: "Ipsley"
   }
])

Condition.create([
   {name: "Epilepsy"}, #! Use Phenytoin
   {name: "Haemophilia"}, #! Do NOT use Aspirin
   {name: "Stroke"} #! Use Warfarin
])
