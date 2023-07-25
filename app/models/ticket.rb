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
class Ticket < ApplicationRecord
  has_many :excavators # NOTE: normally one excavator

  accepts_nested_attributes_for :excavators
end
