app.factory 'Table', ['$http', '$rootScope', '$filter', ($http, $rootScope, $filter) ->
  class Table
    current_page: 0
    items: 
      raw: []
      pages: []
    config:
      search: ''
      items_per_page: 5
      fetch_method: 'get'
      order_by: ''
      order_reverse: false

    constructor: (config) ->
      @config = _.defaults config, @config
      $rootScope.$watch =>
        @config
      , =>
        @foo()
      , yes

    fetch: ->
      $http
        url: @config.fetch_path
        method: @config.fetch_method
      .success (data) =>
        @items.raw = angular.fromJson data
        @foo()

    foo: ->
      data = _.clone @items.raw
      data = $filter('filter')(data, @config.search)
      data = $filter('orderBy')(data, @config.order_by, @config.order_reverse)
      if data.length > @config.items_per_page
        @items.pages = (data.splice(0, @config.items_per_page) while data.length)
      else
        @items.pages = [data]

    set_page: (page) -> @current_page = page

    toggle_order: (order) ->
      if @config.order_by is order then @config.order_reverse = !@config.order_reverse
      else @config.order_by = order
]