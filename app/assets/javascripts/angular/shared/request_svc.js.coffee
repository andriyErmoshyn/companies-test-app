angular.module('companies.request_svc', ['restangular'])

angular.module('companies.request_svc').factory 'Request', ['Restangular', (Restangular) ->
  Restangular.withConfig (RestangularConfigurer) ->
    RestangularConfigurer.setBaseUrl('/api/v1')
    RestangularConfigurer.setRequestSuffix('.json')
  ]
