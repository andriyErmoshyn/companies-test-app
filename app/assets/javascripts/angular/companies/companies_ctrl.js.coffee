angular.module("companies.company", [])

companiesCtrl = ($scope, Request) ->
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

  $scope.deleteBranch = (company, branch) ->
    request = Request.one('companies', company.id).one('branches', branch.id)
    request.remove().then ->
      company.branches.splice(company.branches.indexOf(branch), 1)

angular
  .module "companies.company"
    .controller "companiesCtrl", [
      '$scope', 'Request', companiesCtrl
    ]
