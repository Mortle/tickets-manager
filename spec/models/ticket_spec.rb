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
require 'rails_helper'

RSpec.describe Ticket, type: :model do
  subject(:ticket) { FactoryBot.create(:ticket, request_number: '123abc') }

  # Test associations
  it { is_expected.to have_one(:excavator) }

  # Test validations
  it { is_expected.to validate_presence_of(:request_number) }
  it { is_expected.to validate_uniqueness_of(:request_number) }

  describe 'polygon format validation' do
    before { ticket.polygon = polygon_data }

    context 'with valid polygon data' do
      let(:polygon_data) do
        'POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,-81.08858407706913 32.02259853170128))'
      end

      it 'is valid when the polygon data is in the correct format' do
        expect(ticket).to be_valid
      end
    end

    context 'with invalid polygon data' do
      let(:polygon_data) { 'INVALID_POLYGON_DATA' }

      it 'is not valid when the polygon data is not in the correct format' do
        expect(ticket).not_to be_valid
        expect(ticket.errors[:polygon]).to include('is not in the correct format')
      end
    end

    context 'with nil polygon data' do
      let(:polygon_data) { nil }

      it 'is valid when the polygon data is not present' do
        expect(ticket).to be_valid
      end
    end
  end
end
