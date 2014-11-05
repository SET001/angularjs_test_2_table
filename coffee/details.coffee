window.app = angular.module('app', ['ngRoute', 'ui.bootstrap.modal'])

window.DetailsCtrl = ['$scope', '$modalInstance', 'item', (self, $modalInstance, item) ->

  self.item = _.clone item

  self.ok = ->
    $modalInstance.dismiss 'cancel'
]