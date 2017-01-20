<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ include file="../templates/head-meta.jsp"%>

</head>

<script type="text/javascript">
 
 var myApp = angular.module("myApp",[]);
 
 myApp.factory("FriendService",FriendService);
 
 FriendService.$inject = ['$http','$q'];
 
 function FriendService($http, $q){
	 
	 var BASE_URL = 'http://localhost:9999/Talk/';
	 var service = {};
	 
	 service.viewFriendRequset = viewFriendRequset;
	 service.acceptFriendRequset = acceptFriendRequset;
	 service.rejectFriendRequset = rejectFriendRequset;
	 service.getFriends = getFriends;
	 service.countFriendRequests = countFriendRequests;
	 
	 return service;
	 
	 function viewFriendRequset(){

		 console.log("inside the friendrequest service");
		 return $http.get(BASE_URL + 'friendrequests').then(
					function(response) {
						return response.data;
					}, function(errResponse) {
						return $q.reject(errResponse);
					}); 
	 }
	 
	 function acceptFriendRequset(friendId){
		 console.log(friendId);
		 console.log("inside the accept friend request service");
		 return $http.get(BASE_URL + 'acceptfriendrequest/'+friendId).then(
					function(response) {
						return response.data;
					}, function(errResponse) {
						return $q.reject(errResponse);
					}); 
	 }
	 
	 function rejectFriendRequset(friendId){
		 console.log(friendId);
		 console.log("inside the reject friend request service");
		 return $http.get(BASE_URL + 'rejectfriendrequest/'+friendId).then(
					function(response) {
						return response.data;
					}, function(errResponse) {
						return $q.reject(errResponse);
					}); 
	 }
	 
	 function getFriends(){
		 console.log("inside the get friend request service");
		 return $http.get(BASE_URL + 'getfriends').then(
					function(response) {
						return response.data;
					}, function(errResponse) {
						return $q.reject(errResponse);
					}); 
	 }
	 
	 function countFriendRequests(){
		 console.log("inside the count friend request service");
		 return $http.get(BASE_URL + 'countfriendrequests').then(
					function(response) {
						return response.data;
					}, function(errResponse) {
						return $q.reject(errResponse);
					}); 
	 }
	 
	 
	 
	 
 }
 
 myApp.controller("myCtrl",myCtrl);
 myCtrl.$inject = ["FriendService","$scope"];
 function myCtrl(FriendService, $scope){
	
     $scope.viewFriendRequset = viewFriendRequset;
     $scope.acceptFriendRequset = acceptFriendRequset;
     $scope.rejectFriendRequset = rejectFriendRequset;
     
     getFriends();
     countFriendRequests();
	 
	 function viewFriendRequset() {
		 FriendService.viewFriendRequset()
					.then(function(response) {
							$scope.friendrequest = response;
							
							},
							function(errResponse) {
								console.log('Error fetching Users');
							});
		}
	 
	 function acceptFriendRequset(friendId) {
		 FriendService.acceptFriendRequset(friendId)
					.then(function(response) {
						$scope.friendrequest = response;
						 getFriends();
						 countFriendRequests();
							},
							function(errResponse) {
								console.log('Error fetching Users');
							});
		
		 
		}
	 
	 function rejectFriendRequset(friendId) {
		 FriendService.rejectFriendRequset(friendId)
					.then(function(response) {
						$scope.friendrequest = response;
							},
							function(errResponse) {
								console.log('Error fetching Users');
							});
		}
	 
	 function getFriends() {
		 FriendService.getFriends()
					.then(function(response) {
						$scope.friends = response;
							},
							function(errResponse) {
								console.log('Error fetching Users');
							});
		}
	 
	 function countFriendRequests() {
		 FriendService.countFriendRequests()
					.then(function(response) {
						$scope.countfriendrequests = response.count;
							},
							function(errResponse) {
								console.log('Error fetching Users');
							});
		}
	 
	 
 }
 
 
 
</script>

<body ng-app="myApp" ng-controller="myCtrl">

<%@ include file="../templates/header.jsp"%>



<div class="container">
<h2>Friends</h2>
<div class="col-md-4 col-md-offset-4">
	
	
	<button class="btn btn-success " ng-click="viewFriendRequset();">Friend Requests &nbsp<span class="badge">{{countfriendrequests}}</span></button>
			
		</div>
		
		<!-- <div ng-show="temp">
		no request
		</div> -->
		
		
			<div class="panel-group" ng-show="friendrequest">
				<div class="panel panel-default" ng-repeat="user in friendrequest"
					style="margin-top: 40px">

					<div class="panel-body">
					<img ng-src="
					${pageContext.request.contextPath}/resources/images/{{user.friendId.email}}.jpg "
						class="img-circle" width="40" height="40"
						 onerror="this.src='${pageContext.request.contextPath}/resources/images/user.jpg'"
						width="30" height="30" id="sm_profilepic" />
						
						<h3>{{user.friendId.username}}</h3>
						<i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp&nbsp{{user.friendId.city}}
						
						<div ng-if="user.friendId.gender == 'Male'">
					<i class="fa fa-mars" aria-hidden="true"></i> &nbsp
					{{user.friendId.gender}}
				</div>

				<div ng-if="user.friendId.gender == 'Female'">
					<i class="fa fa-mars" aria-hidden="true"></i> &nbsp
					{{user.friendId.gender}}
					
				</div>
				<hr/>
						<button class="btn btn-success btn-sm" ng-click="acceptFriendRequset(user.friendId.userId);"><i class="fa fa-user-plus" aria-hidden="true"></i>&nbsp ACCEPT</button>
						
						<button class="btn btn-danger btn-sm pull-right" ng-click="rejectFriendRequset(user.friendId.userId);"><i class="fa fa-user-times" aria-hidden="true"></i>&nbsp REJECT</button>
						
					</div>
				</div>
				<hr/>
			</div>
			
			<div>
			
			
				<div class="panel-group" ng-show="friends">
				<div class="panel panel-default" ng-repeat="user in friends"
					style="margin-top: 40px">

					<div class="panel-body">
					<img ng-src="
					${pageContext.request.contextPath}/resources/images/{{user.friendId.email}}.jpg "
						class="img-circle" width="40" height="40"
						 onerror="this.src='${pageContext.request.contextPath}/resources/images/user.jpg'"
						width="30" height="30" id="sm_profilepic" />
						
						<h3>{{user.friendId.username}}</h3>
						<i class="fa fa-envelope-o" aria-hidden="true"></i>&nbsp&nbsp{{user.friendId.email}}<br/>
						
						<i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp&nbsp{{user.friendId.city}}<br/>
						
						<i class="fa fa-phone" aria-hidden="true"></i>&nbsp&nbsp{{user.friendId.phone}}<br/>
						<i class="fa fa-birthday-cake" aria-hidden="true"></i>&nbsp&nbsp{{user.friendId.dob}}
						
						<div ng-if="user.friendId.gender == 'Male'">
					<i class="fa fa-mars" aria-hidden="true"></i> &nbsp
					{{user.friendId.gender}}
				</div>

				<div ng-if="user.friendId.gender == 'Female'">
					<i class="fa fa-mars" aria-hidden="true"></i> &nbsp
					{{user.friendId.gender}}
					
				</div>
				<hr/>
						<button class="btn btn-success btn-sm" ng-click=";"><i class="fa fa-paper-plane-o" aria-hidden="true"></i>&nbsp SEND MESSAGE</button>
						
					</div>
				</div>
				
			</div>
			
			
			</div>
	
</div>

<%@ include file="../templates/footer.jsp"%>

</body>

</html>