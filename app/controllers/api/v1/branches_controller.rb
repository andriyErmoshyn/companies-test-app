# frozen_string_literal: true

module Api
  module V1
    class BranchesController < ApplicationController
      def create
        company = Company.find(params[:company_id])
        branch = company.branches.create!(branch_params)
        json_response branch
      end

      def update
        branch = Branch.find(params[:id])
        branch.update!(branch_params)
        json_response branch
      end

      def destroy
        branch = Branch.find(params[:id])
        branch.delete
      end

      private

      def branch_params
        params.require(:branch).permit(:number, :area)
      end
    end
  end
end
