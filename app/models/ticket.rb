# frozen_string_literal: true

# == Schema Information
#
# Table name: tickets
#
#  id                     :bigint           not null, primary key
#  additional_sa_codes    :string           default([]), is an Array
#  external_data          :jsonb
#  polygon                :text
#  primary_sa_code        :string
#  request_number         :string           not null
#  request_type           :string
#  response_due_timestamp :datetime
#  sequence_number        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_tickets_on_request_number  (request_number) UNIQUE
#
class Ticket < ApplicationRecord
  has_one :excavator, dependent: :destroy

  accepts_nested_attributes_for :excavator

  validates :request_number, presence: true, uniqueness: true
  validate :valid_polygon_format, if: -> { polygon.present? }

  private

  def valid_polygon_format
    errors.add(:polygon, 'is not in the correct format') unless polygon&.match?(/POLYGON\(\((-?\d+(\.\d+)?\s-?\d+(\.\d+)?,?)+\)\)/)
  end
end
