# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_17_213304) do

  create_table "appointments", force: :cascade do |t|
    t.datetime "date"
    t.integer "doctor_id"
    t.integer "patient_id"
    t.text "complaint"
    t.text "diagnosis"
    t.boolean "diagnosis_pending"
    t.string "prescription"
    t.datetime "prescription_expiry"
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "conditions", force: :cascade do |t|
    t.string "name"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "first_name"
    t.string "surname"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email"
    t.string "password_digest"
  end

  create_table "drugs", force: :cascade do |t|
    t.string "name"
    t.string "contra_url"
    t.string "interaction_url"
    t.text "contraindications"
  end

  create_table "patient_conditions", force: :cascade do |t|
    t.string "description"
    t.integer "patient_id"
    t.integer "condition_id"
    t.index ["condition_id"], name: "index_patient_conditions_on_condition_id"
    t.index ["patient_id"], name: "index_patient_conditions_on_patient_id"
  end

  create_table "patient_drugs", force: :cascade do |t|
    t.string "dosage"
    t.integer "patient_id"
    t.integer "drug_id"
    t.boolean "active"
    t.index ["drug_id"], name: "index_patient_drugs_on_drug_id"
    t.index ["patient_id"], name: "index_patient_drugs_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "surname"
    t.datetime "date_of_birth"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "email"
    t.string "uid"
  end

end
