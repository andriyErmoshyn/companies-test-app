# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Layout/MultilineMethodCallIndentation, Metrics/BlockLength
RSpec.describe 'Branches management', type: :request do
  let!(:company) { create :company, :with_branches }
  let(:branch) { company.branches.first }

  describe '#create' do
    context 'with valid params' do
      before do
        @valid_params = { branch: attributes_for(:branch) }
      end
      it 'creates branch' do
        expect { post api_v1_company_branches_path(company.id), params: @valid_params }
          .to change(Branch, :count).by 1
      end

      it 'has status 200' do
        post api_v1_company_branches_path(company.id), params: @valid_params
        expect(response).to have_http_status 200
      end
    end

    context 'with invalid params' do
      before do
        existing_number = company.branches.first.number
        @not_unique_number_params = { branch: { number: existing_number } }
        @empty_number_params = { branch: { number: nil } }
      end

      it 'has unprocessable_entity status' do
        [@not_unique_number_params, @empty_number_params].each do |params|
          post api_v1_company_branches_path(company.id), params: params
          expect(response).to have_http_status 422
        end
      end

      it "doesn't create a branch" do
        [@not_unique_number_params, @empty_number_params].each do |params|
          expect { post api_v1_company_branches_path(company.id), params: params }
            .to not_change(Branch, :count)
        end
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      it 'updates branch' do
        new_number = branch.number + 1
        put api_v1_company_branch_path(company.id, branch.id), params: { branch: { number: new_number } }

        expect(response).to have_http_status 200
        expect(branch.reload.number).to eq new_number
      end
    end

    context 'with invalid params' do
      it 'has unprocessable_entity status if name is empty' do
        new_number = ''
        put api_v1_company_branch_path(company.id, branch.id), params: { branch: { number: new_number } }
        expect(response).to have_http_status 422
      end

      it 'has not_found status if wrong company_id sent' do
        put api_v1_company_branch_path(company.id, 123_456), params: { branch: { number: 123 } }
        expect(response).to have_http_status 404
      end
    end
  end

  describe '#delete' do
    it 'deletes branch' do
      expect { delete api_v1_company_branch_path(company.id, branch.id) }
          .to change(Branch, :count).by(-1)
    end

    it 'has not_found status if wrong company_id sent' do
      delete api_v1_company_branch_path(company.id, 123_456)
      expect(response).to have_http_status 404
    end
  end
  # rubocop:enable Layout/MultilineMethodCallIndentation, Metrics/BlockLength
end
