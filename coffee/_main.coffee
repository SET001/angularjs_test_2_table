window.app = angular.module('app', ['ngRoute', 'ui.bootstrap.modal'])
# NOTES
#
# * in order to make sorting and filtering work globally throught all table, not only on current page, it should be
#   supported on server side. Otherwise, clientside sorting should be performed which is not wise
#   to do on large data ammounts
window.MainCtrl = ['$scope', '$http', '$modal', '$filter', (self, $http, $modal, $filter) ->

  self.awailable_pages = [5, 10, 15, 20, 30, 50, 70, 100]
  
  self.loading = yes

  self.table = new Table

  # self.table =
  #   config:
  #     type: 'full'
  #     search: null
  #     page: 1
  #     per_page: 10
  #     order_by: null
  #     order_reverse: 1
  #   total: null
  #   items: []
  #   pages_count: null
  #   pages: []
  #   fetch: ->
  #     self.loading = yes
  #     $http.jsonp("http://www.json-generator.com/api/json/get/cpUIjdiIMO?indent=2&callback=JSON_CALLBACK").success (response) ->
  #       self.table.items = response
  #       self.table.total = response.length
  #       self.table.operate()
  #     .error (data) ->
  #       console.log "error", data
  #   set_page: (page) ->
  #     @config.page = page
  #     @fetch()
  #   toggle_order: (order) ->
  #     if @config.order_by is order
  #       @config.order_reverse = !@config.order_reverse
  #     else
  #       @config.order_by = order
  #   operate: ->

  #     @items = $filter('filter')(@items, @config.search)
  #     if @config.order_by
  #       @items = $filter('orderBy')(@items, @config.order_by, @config.order_reverse)
  #     @pages_count = Math.ceil @total/@config.per_page
  #     @pages = []
  #     for i in [0..@pages_count]
  #       @pages.push i

  stored = localStorage['mytestconfig']

  if typeof(Storage) != 'undefined'
    if stored
      self.table.config = _.assign self.table.config, $.parseJSON stored
  else
    console.log 'storage can not be used'

  self.$watch 'table.config', (config) ->
    localStorage['mytestconfig'] = JSON.stringify config
    self.table.fetch()
  , yes

  self.table.fetch()

  self.show_details = (item) ->
    $modal.open
      templateUrl: 'templates/item_details.html'
      controller: 'DetailsCtrl'
      resolve:
        item: ->
          item

  self.get_rclass = ->
    if self.table.config.order_reverse then return 'glyphicon-arrow-up'
    'glyphicon-arrow-down'

  # self.block = ->
  #   self.loading = true
  # self.unblock = ->
  #   self.loading = false
]