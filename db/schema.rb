# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140426234017) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "provided_services", force: true do |t|
    t.integer "provider_id"
    t.integer "service_id"
    t.integer "line_srvc_cnt"
    t.integer "bene_unique_cnt"
    t.integer "bene_day_srvc_cnt"
    t.decimal "average_medicare_allowed_amt", precision: 20, scale: 10
    t.decimal "stdev_medicare_allowed_amt",   precision: 20, scale: 10
    t.decimal "average_submitted_chrg_amt",   precision: 20, scale: 10
    t.decimal "stdev_submitted_chrg_amt",     precision: 20, scale: 10
    t.decimal "average_medicare_payment_amt", precision: 20, scale: 10
    t.decimal "stdev_medicare_payment_amt",   precision: 20, scale: 10
  end

  add_index "provided_services", ["service_id", "provider_id"], name: "index_provided_services_on_service_id_and_provider_id", using: :btree

  create_table "providers", force: true do |t|
    t.integer "npi"
    t.string  "nppes_provider_last_org_name"
    t.string  "nppes_provider_first_name"
    t.string  "nppes_provider_mi"
    t.string  "nppes_credentials"
    t.string  "nppes_provider_gender"
    t.string  "nppes_entity_code"
    t.string  "nppes_provider_street1"
    t.string  "nppes_provider_street2"
    t.string  "nppes_provider_city"
    t.string  "nppes_provider_zip"
    t.string  "nppes_provider_state"
    t.string  "nppes_provider_country"
    t.string  "provider_type"
    t.string  "medicare_participation_indicator"
    t.string  "place_of_service"
  end

  add_index "providers", ["npi"], name: "index_providers_on_npi", using: :btree

  create_table "services", force: true do |t|
    t.string "hcpcs_code"
    t.string "hcpcs_description"
  end

  add_index "services", ["hcpcs_code"], name: "index_services_on_hcpcs_code", using: :btree

end
