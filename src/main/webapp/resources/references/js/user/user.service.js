(function () {
    'use strict';

    angular
        .module('app')
        .factory('UserService', UserService);

    UserService.$inject = ['$http'];
    function UserService($http) {
        var service = {};
		
		service.getUserData = getUserData;
		
		return service;
		
		function getUserData(){
			
			$http.post('http://localhost:9999/Talk/userdata').success(
					function(response) {
						$scope.userdetails = response;
					}).error(function(error) {
				console.log(error);
			});
		}
		
		
	}
	
})();