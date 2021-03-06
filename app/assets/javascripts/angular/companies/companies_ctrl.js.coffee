angular.module("companies.company", [])

companiesCtrl = ($scope, $modal, Request) ->
  $scope.search = {}
  $scope.search_fields = [
    { name: 'All fields', value: 'name_or_description_or_address_or_branches_number_or_branches_area_cont' },
    { name: 'Company name', value: 'name_cont' },
    { name: 'Compamny description', value: 'description_cont' },
    { name: 'Company Address', value: 'address_cont' },
    { name: 'Branch Number', value: 'branches_number_cont' },
    { name: 'Branch Area', value: 'branches_area_cont' }
  ]

  loadCompanies = ->
    Request.all('companies').getList().then (companies) ->
      $scope.companies = companies

  loadCompanies()

  $scope.searchParamsEmpty = ->
    !$scope.search.field || !$scope.search.query

  $scope.resetSearch = ->
    $scope.search = {}
    loadCompanies()

  $scope.searchItems = () ->
    request = Request.all('companies')
    field_name = $scope.search.field.value
    query = $scope.search.query
    search_query = { q: "#{field_name}": query }
    request.customGETLIST('', search_query).then (companies) ->
      $scope.companies = companies

  $scope.createCompany = (company) ->
    request = Request.all('companies')
    request.post(company).then (company) ->
      $scope.companies.push(company)
      $scope.newCompanyModal.hide()

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

  $scope.openNewCompanyModal = ->
    new_scope = $scope.$new()
    new_scope.company = {}
    $scope.newCompanyModal = $modal(scope: new_scope, template: 'new_company_form.html', backdrop: false, container: 'body')

  $scope.openEditCompanyModal = (company) ->
    new_scope = $scope.$new()
    new_scope.company = company
    $scope.editCompanyModal = $modal(scope: new_scope, template: 'edit_company_form.html', backdrop: false, container: 'body')

  $scope.createBranch = (company, branch) ->
    request = Request.one('companies', company.id).all('branches')
    request.post(branch).then (branch) ->
      $scope.branchModal.hide()

  $scope.updateBranch = (company, branch) ->
    request = Request.one('companies', company.id).one('branches', branch.id)
    request.branch = {
      number: branch.number,
      area: branch.area
    }
    request.put().then (response) ->
      $scope.branchModal.hide()

  $scope.deleteBranch = (company, branch) ->
    request = Request.one('companies', company.id).one('branches', branch.id)
    request.remove().then ->
      company.branches.splice(company.branches.indexOf(branch), 1)

  $scope.openBranchModal = (company, branch, action) ->
    new_scope = $scope.$new()
    new_scope.company = company
    new_scope.action = action
    if action == 'new_branch'
      new_scope.branch = {}
      new_scope.title = "Create a new branch for #{company.name}"
      new_scope.submitBtnText = 'Create'
    else
      new_scope.branch = branch
      new_scope.title = 'Edit branch'
      new_scope.submitBtnText = 'Update'
    $scope.branchModal = $modal(scope: new_scope, template: 'branch_form.html', backdrop: false, container: 'body')

angular
  .module "companies.company"
    .controller "companiesCtrl", [
      '$scope', '$modal', 'Request', companiesCtrl
    ]
