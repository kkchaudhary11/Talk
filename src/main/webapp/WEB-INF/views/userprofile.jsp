<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ include file="../templates/head-meta.jsp"%>

<style type="text/css">
#upload_link {
	text-decoration: none;
}

#upload {
	display: none
}
</style>
</head>

<script>
	var myApp = angular.module("myApp", []);

	myApp.factory("UserService", [
			"$http",
			"$q",
			function($http, $q) {
				var target_url = 'http://localhost:9999/Talk/';

				return {

					userData : function() {

						return $http.get(target_url + 'userdata').then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									return $q.reject(errResponse);
								});
					},
					
					updateUser : function(item) {
						return $http.post(target_url + 'updateuser', item)
								.then(function(response) {
									return response.data;
								}, function(errResponse) {
									console.error('Error while sending data');
									return $q.reject(errResponse);
								});
					},
					
					
					

					deleteUser : function(item) {
						return $http.post(target_url + 'deleteuser', item)
								.then(function(response) {
									return response.data;
								}, function(errResponse) {
									console.error('Error while sending data');
									return $q.reject(errResponse);
								});
					},

					getAllUsers : function() {
						return $http.get(target_url + 'allusers').then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									return $q.reject(errResponse);
								});
					}
				};
			} ]);

	myApp.controller("myCtrl", [ "$scope", "UserService",
			function($scope, $UserService) {
		


				$UserService.userData().then(function(response) {
					//console.log(response);
					$scope.userdetails = response;
				}, function(errResponse) {
					console.log('Error fetching User Details');
				});
				
				$scope.updateUser = function() {
					
				$scope.UserData = 	{ 
							UserId: $scope.userdetails.userId,
							Username: $scope.userdetails.username,
							Phone: $scope.userdetails.phone,
							City: $scope.userdetails.city,
							DOB: $scope.userdetails.dob,
							Gender: $scope.userdetails.gender
							
						}; 
					console.log($scope.UserData); 
					console.log("in the update user"); 
					
					$UserService.updateUser($scope.UserData).then(function(response) {
						try {
							$scope.status = response;
						} catch (e) {
							$scope.data = [];
						}
						
					}, function(errResponse) {
						console.error('Error while Sending Data.');
					});
				}

				$scope.deleteUser = function(userId) {
					$UserService.deleteUser(userId).then(function(response) {
						try {
							$scope.allusers = response;
						} catch (e) {
							$scope.data = [];
						}
				/* 		console.log($scope.allusers); */
					}, function(errResponse) {
						console.error('Error while Sending Data.');
					});
				}

				$scope.getAllUsers = function() {
					$UserService.getAllUsers().then(function(response) {

						$scope.allusers = response;
					}, function(errResponse) {
						console.log('Error fetching Users');
					});
				}

			} ]);

</script>


<body ng-app="myApp" ng-controller="myCtrl">

	<div class="container" style="margin-top: 10px; margin-bottom: 10px">

		<%@ include file="../templates/header.jsp"%>

	</div>
	<hr />


	<div class="container">

		<div class="col-md-6 col-md-offset-3">
			<div class="col-md-6">
				<div ng-if="userdetails.gender == 'Male'">
					<img
						src="${pageContext.request.contextPath}/resources/images/{{}}.jpg"
						width="150" height="150"
						onerror="this.src='${pageContext.request.contextPath}/resources/images/male_dummy.jpg'">
				</div>
				<div ng-if="userdetails.gender == 'Female'">
					<img
						src="${pageContext.request.contextPath}/resources/images/{{}}.jpg"
						width="150" height="150"
						onerror="this.src='${pageContext.request.contextPath}/resources/images/female_dummy.jpg'">
				</div>


				<!-- <img src="" alt="Profile Image" width="150" height="150" ng-src="{{user.gender_image}}"/><br /> -->
				<!-- <input id="upload" type="file"/>
					<a href="" id="upload_link">Update Picture</a> -->

				<!-- 	<script type="text/javascript">
					$(function(){
						$("#upload_link").on('click', function(e){
						    e.preventDefault();
						    $("#upload:hidden").trigger('click');
						});
						});
					</script> -->

				<!-- 	<form action="rest/file/upload" method="post"
					enctype="multipart/form-data">

					<p>
						Select a file : <input type="file" name="file" size="45" />
					</p>

					<input type="submit" value="Upload It" />
				</form> -->


			</div>

			<div class="col-md-6">
				<div>
					<span style="font-size: xx-large;"> {{userdetails.username}}</span>
				</div>
				
				<div>
					<i class="fa fa-envelope-o" aria-hidden="true"></i>&nbsp
					{{userdetails.email}}
				</div>
				<div>
					<i class="fa fa-phone" aria-hidden="true"></i> &nbsp
					{{userdetails.phone}}
				</div>

				<div>
					<i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp&nbsp
					{{userdetails.city}}
				</div>

				<div>
					<i class="fa fa-birthday-cake" aria-hidden="true"></i>&nbsp
					{{userdetails.dob}}
				</div>

				<div ng-if="userdetails.gender == 'Male'">
					<i class="fa fa-mars" aria-hidden="true"></i> &nbsp
					{{userdetails.gender}}
				</div>

				<div ng-if="userdetails.gender == 'Female'">
					<i class="fa fa-mars" aria-hidden="true"></i> &nbsp
					{{userdetails.gender}}
				</div>
			</div>
		</div>

		<button type="button" class="btn btn-default btn-sm"
			data-toggle="modal" data-target="#myModal">Update Info</button>

		<!-- Modal -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Update Details</h4>
					</div>
					<div class="modal-body">
						<form name="form" action="#" >
						
						
							<div class="form-group" ng-class="{ 'has-error': form.username.$dirty && form.username.$error.required }">
          
							<div class="input-group" style="margin-top: 20px">
								<span class="input-group-addon"><i class="fa fa-user "
									aria-hidden="true"></i></span> <input type="text" class="form-control" name="username" id="username"
								ng-model="userdetails.username" 	 ng-value=userdetails.username required/>
									 </div>
									 <span ng-show="form.username.$dirty && form.username.$error.required" class="help-block">Username is required</span>
      											
							</div>
							<div class="input-group" style="margin-top: 20px">
								<span class="input-group-addon"><i class="fa fa-phone "
									aria-hidden="true"></i></span> <input type="tel" class="form-control"
									ng-value=userdetails.phone ng-model="userdetails.phone"  />
							</div>
							<div class="input-group" style="margin-top: 20px">
								<span class="input-group-addon"><i
									class="fa fa-map-marker fa-lg" aria-hidden="true"></i></span> <input
									type="text" class="form-control" ng-value=userdetails.city ng-model="userdetails.city" />
							</div>

							<div class="input-group" style="margin-top: 20px">
								<span class="input-group-addon"><i class="fa fa-calendar"
									aria-hidden="true"></i></span> <input type="text" class="form-control"
									ng-value=userdetails.dob ng-model="userdetails.dob"/>
							</div>

							<div class="input-group" style="margin-top: 20px">
								<input type="radio" name="gender" ng-model="userdetails.gender" value="Male" >
								Male <input type="radio" ng-model="userdetails.gender" name="gender"  value="Female">
								Female<br>
							</div>

							<div class="modal-footer" style="margin-top: 20px">
								<input type="submit" ng-click="updateUser()" value="Save" class="btn btn-primary"
									data-dismiss="modal">
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
		<span class="text-success">{{status.status}}</span>
	
	</div>

	<div class="container">

		<%
			if (request.isUserInRole("ADMIN")) {
		%>

		<div>

			<h3>
				<i class="fa fa-user-secret" aria-hidden="true"></i>&nbsp
				{{userdetails.role}}
			</h3>

			<button ng-click="getAllUsers()" class="btn btn-primary">Get
				All Users</button>


			<table class="table" ng-show="allusers">
				<thead>

					<tr>
						<th>User Name</th>
						<th>Email</th>
						<th>Phone</th>
						<th>City</th>
						<th>Gender</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<tr ng-repeat="user in allusers">
						<td>{{user.username}}</td>
						<td>{{user.email}}</td>
						<td>{{user.phone}}</td>
						<td>{{user.city}}</td>
						<td>{{user.gender}}</td>
						<td><button class="btn btn-danger btn-sm"
								ng-click="deleteUser(user.userId)">DELETE</button></td>
						<td>{{user.userId}}</td>
					</tr>

				</tbody>
			</table>

		</div>

		<%
			}
		%>
	</div>


</body>
</html>