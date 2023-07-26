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
FactoryBot.define do
  factory :ticket do
    request_number { '09252012-00001' }
    sequence_number { '2421' }
    request_type { 'Normal' }
    response_due_timestamp { '2011-07-13 23:59:59' }
    primary_sa_code { 'ZZGL103' }
    additional_sa_codes { %w[ZZL01 ZZL02 ZZL03] }
    polygon do
      'POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295))'
    end
    external_data { {} }

    after(:create) do |ticket|
      create(:excavator, ticket:)
    end
  end
end
