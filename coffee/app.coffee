window.app = angular.module 'app', []

window.MainCtrl = ['$scope', '$filter', 'Table', (self, $filter, Table) ->
  self.items_per_page = [5, 10, 15, 20, 30, 50, 70, 100]
  self.loading = yes
  self.table = new Table
    fetch_path: 'data.json'
  self.table.fetch()
]