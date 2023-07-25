# == Schema Information
#
# Table name: excavators
#
#  id           :bigint           not null, primary key
#  company_name :string
#  crew_on_site :boolean          default(FALSE), not null
#  full_address :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  ticket_id    :bigint
#
# Indexes
#
#  index_excavators_on_ticket_id  (ticket_id)
#
# Foreign Keys
#
#  fk_rails_...  (ticket_id => tickets.id)
#
FactoryBot.define do
  factory :excavator do
    company_name { "John Doe CONSTRUCTION" }
    crew_on_site { true }
    full_address { "555 Some RD, SOME PARK, ZZ, 55555" }
  end
end
