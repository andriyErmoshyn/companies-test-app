angular.module('companies.company').directive('companiesList', ->
  restrict: 'E'
  templateUrl: 'companies_list.html'
  scope:
    companies: '='
)



