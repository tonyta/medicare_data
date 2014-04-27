class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :hcpcs_code
      t.string :hcpcs_description
    end

    # add_index :services, :hcpcs_code
  end
end
