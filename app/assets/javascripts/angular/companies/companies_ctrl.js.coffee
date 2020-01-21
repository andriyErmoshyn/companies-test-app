angular.module("companies.company", [])

companiesCtrl = ($scope, $modal, Request) ->
  Request.all('companies').getList().then (companies) ->
    $scope.companies = companies

  $scope.archive = (company) ->
    request = Request.one('companies', company.id)
    request.company = { archived: true }
    request.put().then ->
      $scope.companies.splice($scope.companies.indexOf(company), 1)

  $scope.updateCompany = (company) ->
    request = Request.one('companies', company.id)
    request.company = {
      name: company.name,
      description: company.description,
      address: company.address
    }
    request.put().then (response) ->
      $scope.editCompanyModal.hide()

  $scope.deleteCompany = (company) ->
    request = Request.one('companies', company.id)
    request.remove().then ->
      $scope.companies.splice($scope.companies.indexOf(company), 1)

  $scope.updateBranch = (company, branch) ->
    request = Request.one('companies', company.id).one('branches', branch.id)
    request.branch = {
      number: branch.number,
      area: branch.area
    }
    request.put().then (response) ->
      $scope.editBranchModal.hide()

  $scope.deleteBranch = (company, branch) ->
    request = Request.one('companies', company.id).one('branches', branch.id)
    request.remove().then ->
      company.branches.splice(company.branches.indexOf(branch), 1)

  $scope.openEditCompanyModal = (company) ->
    new_scope = $scope.$new()
    new_scope.company = company
    $scope.editCompanyModal = $modal(scope: new_scope, template: 'edit_company_form.html', backdrop: false, container: 'body')

  $scope.openEditBranchModal = (company, branch) ->
    new_scope = $scope.$new()
    new_scope.company = company
    new_scope.branch = branch
    $scope.editBranchModal = $modal(scope: new_scope, template: 'edit_branch_form.html', backdrop: false, container: 'body')

angular
  .module "companies.company"
    .controller "companiesCtrl", [
      '$scope', '$modal', 'Request', companiesCtrl
    ]
