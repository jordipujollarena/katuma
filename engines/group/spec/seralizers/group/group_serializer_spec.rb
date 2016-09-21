require 'rails_helper'

describe Group::GroupSerializer do
  context 'passing a Group instance' do
    let(:group) { FactoryGirl.build(:group) }

    subject { described_class.new(group).to_hash }

    it do
      is_expected.to include(
        id: group.id,
        name: group.name,
        created_at: group.created_at,
        updated_at: group.updated_at
      )
    end
  end
end
