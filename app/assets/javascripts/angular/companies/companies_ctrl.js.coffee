angular.module("companies.company", [])

companiesCtrl = ($scope, Request) ->
  Request.all('companies').getList().then (companies) ->
    $scope.companies = companies

angular
  .module "companies.company"
    .controller "companiesCtrl", [
      '$scope', 'Request', companiesCtrl
    ]
