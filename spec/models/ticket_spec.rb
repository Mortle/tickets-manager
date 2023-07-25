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
# spec/models/ticket_spec.rb
require 'rails_helper'

RSpec.describe Ticket, type: :model do
  subject { FactoryBot.create(:ticket, request_number: '123abc') }

  # Test associations
  it { should have_one(:excavator) }

  # Test validations
  it { should validate_presence_of(:request_number) }
  it { should validate_uniqueness_of(:request_number) }
end
