# frozen_string_literal: true

class CreateExcavators < ActiveRecord::Migration[7.0]
  def change
    create_table :excavators do |t|
      t.belongs_to :ticket, foreign_key: true

      t.string :company_name
      t.string :full_address

      t.boolean :crew_on_site, default: false, null: false

      t.timestamps
    end
  end
end
