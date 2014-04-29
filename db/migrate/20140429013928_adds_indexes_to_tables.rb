class AddsIndexesToTables < ActiveRecord::Migration
  def change
    add_index :providers, :npi
    add_index :providers, :nppes_provider_zip
    add_index :providers, :nppes_provider_city
    add_index :providers, :nppes_provider_state
    add_index :providers, :nppes_provider_country

    add_index :services, :hcpcs_code

    add_index :provided_services, :provider_id
    add_index :provided_services, [:service_id, :provider_id]

  end
end
