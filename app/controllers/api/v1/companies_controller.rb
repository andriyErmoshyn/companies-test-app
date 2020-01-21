# frozen_string_literal: true

module Api
  module V1
    class CompaniesController < ApplicationController
      def index
        companies = Company.not_archived.recently_updated
        json_response companies
      end

      def create
        company = Company.create!(create_company_params)
        json_response company
      end

      def update
        company = Company.find(params[:id])
        company.update!(update_company_params)
        json_response company
      end

      def destroy
        company = Company.find(params[:id])
        company.delete
      end

      private

      def create_company_params
        params.require(:company).permit(
          :name, :description, :address,
          branches_attributes: %i[number area]
        )
      end

      def update_company_params
        params.require(:company).permit(
          :id, :name, :description, :address, :archived
        )
      end
    end
  end
end
