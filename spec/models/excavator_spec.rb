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
# spec/models/excavator_spec.rb
require 'rails_helper'

RSpec.describe Excavator, type: :model do
  # Test associations
  it { should belong_to(:ticket) }

  # Test validations
  it { should validate_presence_of(:crew_on_site) }
end
