require "csv"

ActiveRecord::Base.establish_connection

@provider_id_counter = 0
@service_id_counter = 1

@provider_id = nil
@service_id = nil

@provider_npi_cache = nil

@service_cache = {}

# @provider_keys = "id, npi, nppes_provider_last_org_name, nppes_provider_first_name, nppes_provider_mi, nppes_credentials, nppes_provider_gender, nppes_entity_code, nppes_provider_street1, nppes_provider_street2, nppes_provider_city, nppes_provider_zip, nppes_provider_state, nppes_provider_country, provider_type, medicare_participation_indicator, place_of_service"
# @service_keys = "id, hcpcs_code, hcpcs_description"
# @provided_service_keys = "id, provider_id, service_id, line_srvc_cnt, bene_unique_cnt, bene_day_srvc_cnt, average_medicare_allowed_amt, stdev_medicare_allowed_amt, average_submitted_chrg_amt, stdev_submitted_chrg_amt, average_medicare_payment_amt, stdev_medicare_payment_amt"

def seed_line(data_array)
  unless @provider_npi_cache == data_array[0]
    ActiveRecord::Base.connection.execute(%q{
      INSERT INTO providers (npi, nppes_provider_last_org_name, nppes_provider_first_name, nppes_provider_mi, nppes_credentials, nppes_provider_gender, nppes_entity_code, nppes_provider_street1, nppes_provider_street2, nppes_provider_city, nppes_provider_zip, nppes_provider_state, nppes_provider_country, provider_type, medicare_participation_indicator, place_of_service)
      VALUES (%s, '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s', '%s');
    } % data_array[0..15] )
    @provider_npi_cache = data_array[0]
    @provider_id_counter += 1
  end

  if @service_cache.has_key?(data_array[16])
    @service_id = @service_cache[data_array[16]]
  else
    ActiveRecord::Base.connection.execute(%q{
      INSERT INTO services (hcpcs_code, hcpcs_description)
      VALUES ('%s', '%s');
    } % data_array[16..17] )
    @service_cache[data_array[16]] = @service_id_counter
    @service_id_counter += 1
    @service_id = @service_id_counter
  end

  ActiveRecord::Base.connection.execute(%q{
    INSERT INTO provided_services (provider_id, service_id, line_srvc_cnt, bene_unique_cnt, bene_day_srvc_cnt, average_medicare_allowed_amt, stdev_medicare_allowed_amt, average_submitted_chrg_amt, stdev_submitted_chrg_amt, average_medicare_payment_amt, stdev_medicare_payment_amt)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
  } % ([@provider_id_counter, @service_id] + data_array[18..26]) )
end

tsv = Rails.root.join('db', 'data', 'med_full.txt')
parsed_tsv = CSV.open(tsv, col_sep: "\t")

parsed_tsv.readline # skips line
parsed_tsv.readline # skips line

start_time = Time.now

parsed_tsv.each_entry.with_index do |entry, index|
  puts "Now seeding record no. #{index}" if index % 50_000 == 0
  seed_line(entry)
end

puts "Seed Time: #{Time.now - start_time} seconds."
