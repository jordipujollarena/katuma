require 'rails_helper'

module Suppliers
  describe OrdersFrequencySerializer do
    let(:group) { FactoryGirl.create(:group) }
    let(:schedule) do
      IceCube::Schedule.new do |f|
        f.add_recurrence_rule IceCube::Rule.weekly
      end
    end
    let(:orders_frequency) do
      FactoryGirl.create(
        :orders_frequency,
        group_id: group.id,
        ical: schedule.to_ical,
        frequency_type: OrdersFrequency::FREQUENCY_TYPES[:confirmation]
      )
    end
    let(:attributes) do
      {
        id: orders_frequency.id,
        group_id: orders_frequency.group_id,
        to_ical: schedule.to_ical,
        frequency_type: orders_frequency.frequency_type,
        created_at: orders_frequency.created_at,
        updated_at: orders_frequency.updated_at
      }
    end

    subject { described_class.new(orders_frequency).to_hash }

    it { is_expected.to match(attributes) }
  end
end