require 'rails_helper'
require_relative '../../../../../../../spec/support/shared_examples/controllers.rb'
require_relative '../../../../../../../spec/support/authentication.rb'

module Account
  module Api
    module V1
      describe UsersController do
        routes { Account::Engine.routes }

        let(:user) { FactoryGirl.create(:user) }
        let(:user2) { FactoryGirl.create(:user) }
        let(:user3) { FactoryGirl.create(:user) }
        let(:group) { FactoryGirl.create(:group) }
        let(:group1) { FactoryGirl.create(:group) }
        let(:group2) { FactoryGirl.create(:group) }
        let(:membership) { FactoryGirl.create(:membership) }

        context 'Not authenticaded user' do
          xdescribe 'GET #show' do
            subject { get :show, id: 666 }

            it_behaves_like 'an unauthorized request'
          end

          xdescribe 'POST #create' do
            let(:parameters) do
              {
                name: 'ciola',
                email: 'ciola@caola.com',
                password: 'secret',
                password_confirmation: 'secret'
              }
            end

            subject { post :create, parameters }

            it_behaves_like 'a successful request'

            it 'creates a new user with the given parameters' do
              subject
              user = User.last

              expect(user.name).to eq 'ciola'
              expect(user.email).to eq 'ciola@caola.com'
            end
          end

          xdescribe 'PUT #update' do
            subject { put :update, id: 666, name: 'ciola' }

            it_behaves_like 'an unauthorized request'
          end

          xdescribe 'DELETE #destroy' do
            subject { delete :destroy, id: 666 }

            it_behaves_like 'an unauthorized request'
          end

          xdescribe 'GET #account' do
            subject { get :account }

            it_behaves_like 'an unauthorized request'
          end
        end

        context 'Authenticated user' do
          before { authenticate_as user }

          xdescribe 'GET #show' do
            context 'when the user is authorized' do
              subject { get :show, id: user.id }

              it_behaves_like 'a successful request'

              it 'returns the user details' do
                expect(subject.body).to eq UserSerializer.new(user).to_json
              end
            end

            context 'when the user is NOT authorized' do
              subject { get :show, id: user2.id }

              it_behaves_like 'a forbidden request'
            end
          end

          xdescribe 'PUT #update' do
            context 'when the user is authorized' do
              subject { put :update, id: user.id, name: 'ciola' }

              it_behaves_like 'a successful request'

              it 'updates the attributes' do
                expect do
                  subject
                  user.reload
                end.to change { user.name }.to('ciola')
              end

              it 'returns the user details' do
                expect(subject.body).to eq UserSerializer.new(user.reload).to_json
              end
            end

            context 'when the user is NOT authorized' do
              subject { put :update, id: user2.id, name: 'ciola' }

              it_behaves_like 'a forbidden request'
            end
          end

          xdescribe 'DELETE #destroy' do
            context 'when the user is authorized' do
              subject { delete :destroy, id: user.id }

              it_behaves_like 'a successful request'

              it 'deletes the user' do
                expect do
                  subject
                end.to change { User.count }.from(1).to(0)
              end
            end

            context 'when the user is NOT authorized' do
              subject { delete :destroy, id: user2.id }

              it_behaves_like 'a forbidden request'
            end
          end

          xdescribe 'GET #account' do
            subject { get :account }

            it_behaves_like 'a successful request'

            it 'returns the current user details' do
              expect(subject.body).to eq UserSerializer.new(user).to_json
            end
          end
        end
      end
    end
  end
end
