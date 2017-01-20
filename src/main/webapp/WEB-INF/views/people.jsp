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
	 
	 service.getAllUsers = getAllUsers;
	 service.sendFriendRequset = sendFriendRequset;
	 
	 return service;
	 
	 function getAllUsers(){

		 console.log("inside the getallusers service");
		 return $http.get(BASE_URL + 'getusers').then(
					function(response) {
						return response.data;
					}, function(errResponse) {
						return $q.reject(errResponse);
					}); 
	 }
	 
	 function sendFriendRequset(id){
		 console.log("inside the sendRequst service");
		 return $http.post(BASE_URL + 'friendrequest',id).then(
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
	
     $scope.sendFriendRequset = sendFriendRequset;
	 
	 
	 getAllUsers();
	 
	 function getAllUsers() {
		 console.log("in the getallusers");
		 FriendService.getAllUsers()
					.then(function(response) {
						$scope.allusers = response;
							},
							function(errResponse) {
								console.log('Error fetching Users');
							});
		}
	 
	 function sendFriendRequset(FriendId) {
		 console.log(FriendId);
		 FriendService.sendFriendRequset(FriendId)
					.then(function(response) {
						$scope.status = response.status;
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
<h2>People</h2>
<div class="col-md-4 col-md-offset-4">
	<div ng-show="status">
			<p class="alert alert-info">
				<b>Success!</b>&nbsp{{status}}<br />
			</p>
		</div>
		
		<input type="text" class="form-control" placeholder="Search for people" ng-model="searchText"> 

	<div class="panel-group" ng-show="allusers">
				<div class="panel panel-default" ng-repeat="user in allusers | filter:searchText "
					style="margin-top: 40px">

					<div class="panel-body">
					<img ng-src="
					${pageContext.request.contextPath}/resources/images/{{user.email}}.jpg "
						class="img-circle" width="40" height="40"
						 onerror="this.src='${pageContext.request.contextPath}/resources/images/user.jpg'"
						width="30" height="30" id="sm_profilepic" />
						
						<h3>{{user.username}}</h3>
						<i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp&nbsp{{user.city}}
						
						<div ng-if="user.gender == 'Male'">
					<i class="fa fa-mars" aria-hidden="true"></i> &nbsp
					{{user.gender}}
				</div>

				<div ng-if="user.gender == 'Female'">
					<i class="fa fa-mars" aria-hidden="true"></i> &nbsp
					{{user.gender}}
					
				</div>
				<hr/>
						<button class="btn btn-success btn-sm" ng-click="sendFriendRequset(user.userId);"><i class="fa fa-user-plus" aria-hidden="true"></i>&nbsp Send Requset</button>
						
					</div>
				</div>
			</div>
		</div>
</div>

<%@ include file="../templates/footer.jsp"%>

</body>

</html>