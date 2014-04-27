class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.integer :npi
      t.string :nppes_provider_last_org_name
      t.string :nppes_provider_first_name
      t.string :nppes_provider_mi
      t.string :nppes_credentials
      t.string :nppes_provider_gender
      t.string :nppes_entity_code
      t.string :nppes_provider_street1
      t.string :nppes_provider_street2
      t.string :nppes_provider_city
      t.string :nppes_provider_zip
      t.string :nppes_provider_state
      t.string :nppes_provider_country
      t.string :provider_type
      t.string :medicare_participation_indicator
      t.string :place_of_service
    end

    add_index :providers, :npi
  end
end
