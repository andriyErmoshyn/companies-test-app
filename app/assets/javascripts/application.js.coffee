//= require jquery
//= require jquery_ujs
//= require angular
//= require angular-animate
//= require angular-route
//= require angular-aria
//= require angular-sanitize
//= require restangular
//= require angular-contenteditable
//= require angular-strap
//= require angular-strap-tpl
//= require lodash
//= require bootstrap-sprockets
//= require angular-rails-templates

//= require_tree ./templates
//= require_tree ./angular/companies
//= require_tree ./angular/shared

angular.module('companiesApp', [
  'companies.company',
  'companies.request_svc',
  'templates',
  'ngAnimate',
  'mgcrea.ngStrap'
])
