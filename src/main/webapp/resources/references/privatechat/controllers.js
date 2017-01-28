(function(angular) {
  angular.module("chatApp.controllers").controller("ChatCtrl", function($scope, ChatService) {
    $scope.messages = [];
    $scope.message = "";
    $scope.max = 140;
    $scope.userid = "";
    $scope.friendid="";
    
   /* ChatService.getids().then(function(response) {
    	$scope.userid = response.userId;
    	$scope.friendid= response.friendId;
    	console.log("User ID :"+$scope.userid);
    	console.log("Friend ID :"+$scope.friendid);
    	
    	
	});*/
    
    $scope.addMessage = function() {
      ChatService.send($scope.message);
      $scope.message = "";
    };
    
    ChatService.receive().then(null, null, function(message) {
      $scope.messages.push(message);
    });
  });
})(angular);