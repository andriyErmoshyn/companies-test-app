class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :address

  has_many :branches, serializer: BranchSerializer
end
