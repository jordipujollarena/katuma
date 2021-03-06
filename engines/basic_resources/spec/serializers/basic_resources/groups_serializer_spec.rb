require 'rails_helper'

module BasicResources
  describe GroupsSerializer do
    context 'Passing a collection of Group instances' do
      let(:first_group) { FactoryGirl.create(:group) }
      let(:second_group) { FactoryGirl.create(:group) }

      subject { described_class.new([first_group, second_group]).to_hash }

      it 'returns the expected attributes' do
        is_expected.to include(
          {
            id: first_group.id,
            name: first_group.name,
            created_at: first_group.created_at,
            updated_at: first_group.updated_at
          },
          {
            id: second_group.id,
            name: second_group.name,
            created_at: second_group.created_at,
            updated_at: second_group.updated_at
          }
        )
      end
    end
  end
end
