class CreateProvidedServices < ActiveRecord::Migration
  def change
    create_table :provided_services do |t|
      t.integer :provider_id
      t.integer :service_id

      t.integer :line_srvc_cnt
      t.integer :bene_unique_cnt
      t.integer :bene_day_srvc_cnt

      t.decimal :average_medicare_allowed_amt, precision: 20, scale: 10
      t.decimal :stdev_medicare_allowed_amt, precision: 20, scale: 10
      t.decimal :average_submitted_chrg_amt, precision: 20, scale: 10
      t.decimal :stdev_submitted_chrg_amt, precision: 20, scale: 10
      t.decimal :average_medicare_payment_amt, precision: 20, scale: 10
      t.decimal :stdev_medicare_payment_amt, precision: 20, scale: 10
    end

    add_index :provided_services, [:service_id, :provider_id]
  end
end
