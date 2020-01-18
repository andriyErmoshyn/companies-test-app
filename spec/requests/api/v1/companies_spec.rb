# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable Style/RedundantParentheses, Lint/AmbiguousOperator
# rubocop:disable Layout/MultilineMethodCallIndentation, Metrics/BlockLength
RSpec.describe 'Companies management', type: :request do
  describe '#index' do
    it 'is successful' do
      get api_v1_companies_path
      expect(response).to have_http_status 200
    end
  end

  describe '#create' do
    context 'with valid params' do
      before do
        company_attributes = attributes_for :company
        branch_attributes1 = attributes_for :branch
        branch_attributes2 = attributes_for :branch
        @valid_params = {
          company: company_attributes.merge(
            branches_attributes: [
              branch_attributes1,
              branch_attributes2
            ]
          )
        }
      end

      it 'creates company with branches' do
        expect { post api_v1_companies_path, params: @valid_params }
          .to change(Company, :count).by(1)
          .and change(Branch, :count).by 2
      end

      it 'has status 200' do
        post api_v1_companies_path, params: @valid_params
        expect(response).to have_http_status 200
      end
    end

    context 'with invalid params' do
      before do
        company_attributes = attributes_for :company
        branch_attributes = attributes_for :branch
        @invalid_params = {
          company: company_attributes.merge(
            branches_attributes: [
              branch_attributes,
              branch_attributes
            ]
          )
        }
      end

      it 'has unprocessable_entity status' do
        post api_v1_companies_path, params: { company: { name: '', description: 'test' } }
        expect(response).to have_http_status 422
      end

      context 'when branches numbers are not unique' do
        it 'has unprocessable_entity status' do
          post api_v1_companies_path, params: @invalid_params
          expect(response).to have_http_status 422
        end

        it "doesn't create neither Company nor Branch" do
          expect { post api_v1_companies_path, params: @invalid_params }
            .to not_change(Company, :count)
            .and not_change(Branch, :count)
        end
      end
    end
  end

  describe '#update' do
    let!(:company) { create :company }
    context 'with valid params' do
      it 'updates company' do
        new_name = 'NewName'
        put api_v1_company_path(company.id), params: { company: { name: new_name } }

        expect(response).to have_http_status 200
        expect(company.reload.name).to eq new_name
      end
    end

    context 'with invalid params' do
      it 'has unprocessable_entity status if name is empty' do
        new_name = ''
        put api_v1_company_path(company.id), params: { company: { name: new_name } }
        expect(response).to have_http_status 422
      end

      it 'has not_found status if wrong company_id sent' do
        put api_v1_company_path(123_456), params: { company: { name: 'NewName' } }
        expect(response).to have_http_status 404
      end
    end
  end

  describe '#destroy' do
    let!(:company) { create :company, :with_branches }

    it 'deletes company with branches' do
      branches_count = company.branches.count
      expect { delete api_v1_company_path(company.id) }
        .to change(Company, :count).by(-1)
        .and change(Branch, :count).by -(branches_count)
    end

    it 'has not_found status if wrong company_id sent' do
      delete api_v1_company_path(123_456)
      expect(response).to have_http_status 404
    end
  end
  # rubocop:enable Style/RedundantParentheses, Lint/AmbiguousOperator
  # rubocop:enable Layout/MultilineMethodCallIndentation, Metrics/BlockLength
end
