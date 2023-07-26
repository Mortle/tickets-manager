# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :request_number, null: false
      t.string :request_type
      t.string :sequence_number
      t.string :primary_sa_code
      t.string :additional_sa_codes, array: true, default: []

      t.text :polygon

      t.jsonb :external_data, default: {}

      t.datetime :response_due_timestamp

      t.timestamps
    end

    add_index :tickets, :request_number, unique: true
  end
end
