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

  describe 'polygon format validation' do
    it 'is valid when the polygon data is in the correct format' do
      subject.polygon = "POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,-81.08858407706913 32.02259853170128))"
      expect(subject).to be_valid
    end

    it 'is not valid when the polygon data is not in the correct format' do
      subject.polygon = "INVALID_POLYGON_DATA"
      expect(subject).not_to be_valid
      expect(subject.errors[:polygon]).to include('is not in the correct format')
    end

    it 'is valid when the polygon data is not present' do
      subject.polygon = nil
      expect(subject).to be_valid
    end
  end
end