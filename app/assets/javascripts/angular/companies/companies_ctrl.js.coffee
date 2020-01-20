angular.module("companies.company", [])

companiesCtrl = ($scope, Request) ->
  Request.all('companies').getList().then (companies) ->
    $scope.companies = companies

  $scope.archive = (company) ->
    request = Request.one('companies', company.id)
    request.company = { archived: true }
    request.put().then ->
      $scope.companies.splice($scope.companies.indexOf(company), 1)

angular
  .module "companies.company"
    .controller "companiesCtrl", [
      '$scope', 'Request', companiesCtrl
    ]
