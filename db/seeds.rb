require "csv"

tsv = Rails.root.join('db', 'data', 'med_truncated.txt')

def provider_id(args)
  args.slice(:npi)
end

def service_id(args)
  args.slice(:hcpcs_code)
end

def provided_service_id(args)
  { provider_id: args[:npi], service_id: args[:hcpcs_code] }
end

def provider_args(args)
  args.slice(
    :npi,
    :nppes_provider_last_org_name,
    :nppes_provider_first_name,
    :nppes_provider_mi,
    :nppes_credentials,
    :nppes_provider_gender,
    :nppes_entity_code,
    :nppes_provider_street1,
    :nppes_provider_street2,
    :nppes_provider_city,
    :nppes_provider_zip,
    :nppes_provider_state,
    :nppes_provider_country,
    :medicare_participation_indicator
  )
end

def service_args(args)
  args.slice(
    :hcpcs_code,
    :hcpcs_description
  )
end

def provided_service_args(args)
  args.slice(
    :line_srvc_cnt,
    :bene_unique_cnt,
    :bene_day_srvc_cnt,
    :average_medicare_allowed_amt,
    :stdev_medicare_allowed_amt,
    :average_submitted_chrg_amt,
    :stdev_submitted_chrg_amt,
    :average_medicare_payment_amt,
    :stdev_medicare_payment_amt
  )
end

def fetch_provider(args)
  Provider.find_by( provider_id(args) ) ||
  Provider.create!( provider_args(args) )
end

def fetch_service(args)
  Service.find_by( service_id(args) ) ||
  Service.create!( service_args(args) )
end

def fetch_provided_service(args)
  ProvidedService.create!( provided_service_args(args) )
end

def create_association(args)
  provider = fetch_provider(args)
  service = fetch_service(args)
  provided_service = fetch_provided_service(args)
  provided_service.update(provider_id: provider.id, service_id: service.id)

  # provided_service.provider = provider
  # provided_service.service = service
end

parsed_tsv = CSV.open(tsv, col_sep: "\t",
                      headers: true,
                      header_converters: [:downcase, :symbol])

parsed_tsv.readline # skips first line

start_time = Time.now

parsed_tsv.each_entry.with_index do |entry, index|
  puts "Now seeding record no. #{index}" if index % 1000 == 0
  create_association(entry.to_hash)
end

puts "Seed Time: #{Time.now - start_time} seconds."