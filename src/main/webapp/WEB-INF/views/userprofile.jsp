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
	
	
///////////////////////////////////////
	myApp.service('fileUpload', ['$http', function ($http) {
	    this.uploadFileToUrl = function(file, paramuser, uploadUrl){
	        var fd = new FormData();
	        fd.append('file', file);
	        //fd.append('user','vasudev89');
	        return $http.post(uploadUrl, fd, {
	            transformRequest: angular.identity,
	            headers: {'Content-Type': undefined , user: paramuser}
	        })
	        .then(
                    function(response){
                        return response.data;
                    }, 
                    function(errResponse){
                        console.error('Error while updating User');
                        return "error";
                    }
            );
	    }
	}]);
	
///////////////////////////////////////

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
					
					updatePassword : function(item) {
						return $http.post(target_url + 'updatepassword', item)
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

	myApp
			.controller(
					"myCtrl",
					[
							"$scope",
							"UserService",
							function($scope, $UserService,$fileUpload) {

								$UserService
										.userData()
										.then(
												function(response) {
													//console.log(response);
													$scope.userdetails = response;
												},
												function(errResponse) {
													console
															.log('Error fetching User Details');
												});

								$scope.updateUser = function() {

									$scope.UserData = {
										UserId : $scope.userdetails.userId,
										Username : $scope.userdetails.username,
										Phone : $scope.userdetails.phone,
										City : $scope.userdetails.city,
										DOB : $scope.userdetails.dob,
										Gender : $scope.userdetails.gender

									};
									console.log($scope.UserData);
									console.log("in the update user");

									$UserService
											.updateUser($scope.UserData)
											.then(
													function(response) {
														try {
															$scope.status = response;
														} catch (e) {
															$scope.data = [];
														}

													},
													function(errResponse) {
														console
																.error('Error while Sending Data.');
													});
								}

								$scope.deleteUser = function(userId) {
									$UserService
											.deleteUser(userId)
											.then(
													function(response) {
														try {
															$scope.allusers = response;
														} catch (e) {
															$scope.data = [];
														}
														/* 		console.log($scope.allusers); */
													},
													function(errResponse) {
														console
																.error('Error while Sending Data.');
													});
								}

								$scope.updatePassword = function() {
																			
										console.log("in the update password update");

										$UserService
												.updatePassword( $scope.userdetails.newpassword)
												.then(
														function(response) {
															try {
																$scope.status = response;
															} catch (e) {
																$scope.data = [];
															}

														},
														function(errResponse) {
															console
																	.error('Error while Sending Data.');
														});


								}

								$scope.getAllUsers = function() {
									$UserService
											.getAllUsers()
											.then(
													function(response) {

														$scope.allusers = response;
													},
													function(errResponse) {
														console
																.log('Error fetching Users');
													});
								}
								
								
								$scope.openFileChooser = function()
								{
									$('#trigger').trigger('click');
								};
								
								$scope.picUpdated = false;
								$scope.picUpdatedWithError = false;
								$scope.invalidPicType = false;
								
								$scope.picDeleted = false;
								
								$scope.setFile = function(element){
									
									$scope.currentFile = element.files[0];
									
									var extension = $scope.currentFile.name.substring($scope.currentFile.name.lastIndexOf('.'));
									
									var validFileType = ".jpg";
									 if (validFileType.toLowerCase().indexOf(extension) < 0) {
									    	$scope.invalidPicType = true;
											
											window.setTimeout(function()
								    		{
								    			$scope.$apply($scope.invalidPicType = false);
								    		}, 5000);
									    }
									 else
									    {
									    	var reader = new FileReader();
								  			reader.onload = function(event)
											{
								    			
								    			$scope.$apply()
								  			};
								  			// when the file is read it triggers the onload event above.
								  			reader.readAsDataURL(element.files[0]);
								  			
								  		
											$scope.stateDisabled = true;
									    	//
											var file = $scope.currentFile;
								  	        console.log('file is ' );
								  	        console.dir(file);
								  	        var uploadUrl = "http://localhost:9999/Talk/updateProfilePicture/";
								  	      var res = $fileUpload.uploadFileToUrl(file, $scope.data.Username ,uploadUrl).then(
								            		function(response)
								            		{
								            			$scope.response = response.status;
								            			$scope.imagesrc = response.imagesrc;
								            			
								            			//console.log( $scope.response );
								            			//console.log( $scope.imagesrc );
								            			
								            			if( $scope.response == "Uploaded" )
										            			{
										            				$scope.picUpdated = true;
										            				
										            				window.setTimeout(function()
										        		    		{
										        		    			$scope.$apply($scope.picUpdated = false);
										        		    		}, 5000);
										        		    		
										            				$scope.currentImage = '${pageContext.request.contextPath}/' + $scope.imagesrc;
										            				
										            				$scope.defaultPic = ( $scope.currentImage == '/monkeybusiness/resources/images/profilepic_male.jpg' || $scope.currentImage == '/monkeybusiness/resources/images/profilepic_female.jpg' );
										            			}
								            			else
								            			{
															$scope.picUpdatedWithError = true;
								            				
								            				window.setTimeout(function()
								        		    		{
								        		    			$scope.$apply($scope.picUpdatedWithError = false);
								        		    		}, 5000);
								            				
								            				//console.log($scope.currentImage);
								            				
								            				document.getElementById("profilepic").src = $scope.currentImage;
								            			}
								            			$scope.progressObj.SwitchFlag(false);
									    				$scope.stateDisabled = false;
									    				
									    				
								            		}, 
								            		
								            		 function(errResponse)
										                {
										                	console.error('Error while Updating User.');
										                } 
								  	    );
								  	  
									};
								            		
								            			
									
								}
								
								
								

							} ]);
</script>


<body ng-app="myApp" ng-controller="myCtrl">
<header style="padding-top: 10px; padding-bottom: 10px">
	<div class="container"  >

		<%@ include file="../templates/header.jsp"%>

	</div>
	</header>
	
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
			
			<div>
			<button type="button" class="btn btn-link" ng-click="openFileChooser();">Change Picture</button>
			
			<input type="file" id="trigger" ng-show="false" onchange="angular.element(this).scope().setFile(this)" accept="image/*" file-model="myFile"/>
								
								
			</div>	
			


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
		<br /> 

		<!-- Modal for update user details -->
		<div class="modal fade" id="myModal" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Update Details</h4>
					</div>
					<div class="modal-body">
						<form name="form" action="#">


							<div class="form-group"
								ng-class="{ 'has-error': form.username.$dirty && form.username.$error.required }">

								<div class="input-group" style="margin-top: 20px">
									<span class="input-group-addon"><i class="fa fa-user "
										aria-hidden="true"></i></span> <input type="text"
										class="form-control" name="username" id="username"
										ng-model="userdetails.username" ng-value=userdetails.username
										required />
								</div>
								<span
									ng-show="form.username.$dirty && form.username.$error.required"
									class="help-block">Username is required</span>
							</div>

							<div class="input-group" style="margin-top: 20px">
								<span class="input-group-addon"><i class="fa fa-phone "
									aria-hidden="true"></i></span> <input type="tel" class="form-control"
									ng-value=userdetails.phone ng-model="userdetails.phone" />
							</div>
							<div class="input-group" style="margin-top: 20px">
								<span class="input-group-addon"><i
									class="fa fa-map-marker fa-lg" aria-hidden="true"></i></span> <input
									type="text" class="form-control" ng-value=userdetails.city
									ng-model="userdetails.city" />
							</div>

							<div class="input-group" style="margin-top: 20px">
								<span class="input-group-addon"><i class="fa fa-calendar"
									aria-hidden="true"></i></span> <input type="text" class="form-control"
									ng-value=userdetails.dob ng-model="userdetails.dob" />
							</div>

							<div class="input-group" style="margin-top: 20px">
								<input type="radio" name="gender" ng-model="userdetails.gender"
									value="Male"> Male &nbsp <input type="radio"
									ng-model="userdetails.gender" name="gender" value="Female">
								Female<br>
							</div>


							<div class="modal-footer" style="margin-top: 20px"	>
								<input type="submit" ng-click="updateUser()" value="Save"
									class="btn btn-primary" data-dismiss="modal" ng-disabled="form.username.$dirty && form.username.$error.required">
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>
		<span class="text-success">{{status.status}}</span>
		
		<br/>
		<button type="button" class="btn btn-default btn-sm"
			data-toggle="modal" data-target="#myModal2">Change Password</button>


		<!-- Modal for update password -->
		<div class="modal fade" id="myModal2" role="dialog">
			<div class="modal-dialog modal-sm">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Update Details</h4>
					</div>
					<div class="modal-body">
						<form name="form2" action="#">


							<div class="form-group"
								ng-class="{ 'has-error': form2.current_password.$dirty && form2.current_password.$error.required }">

								<div class="input-group" style="margin-top: 20px">
									<span class="input-group-addon"><i
										class="fa fa-unlock-alt" aria-hidden="true"></i></span> <input
										type="password" class="form-control"
										name="current_password" id="current_password"
										placeholder="Enter current password"
										ng-model="userdetails.currentpassword" required />
								</div>
								<span
									ng-show="form2.current_password.$dirty && form2.current_password.$error.required"
									class="help-block">Current Password is required</span>
							</div>

							<div
								ng-if="(userdetails.password != userdetails.currentpassword && form2.current_password.$dirty)">
								<span class="text-danger">Password is Incorrect</span></div>


							<div class="form-group"
								ng-class="{ 'has-error': form2.new_password.$dirty && form2.new_password.$error.required }">

								<div class="input-group" style="margin-top: 20px">
									<span class="input-group-addon"><i class="fa fa-lock"
										aria-hidden="true"></i></span> <input type="password"
										class="form-control" name="new_password" id="new_password"
										placeholder="Enter new password"
										ng-model="userdetails.newpassword" required />
								</div>
								<span
									ng-show="form2.new_password.$dirty && form2.new_password.$error.required"
									class="help-block">New Password is required</span>
							</div>
							<div class="form-group"
								ng-class="{ 'has-error': form2.cnfrm_new_password.$dirty && form2.cnfrm_new_password.$error.required }">

								<div class="input-group" style="margin-top: 20px">
									<span class="input-group-addon"><i class="fa fa-lock"
										aria-hidden="true"></i></span> <input type="password"
										class="form-control" name="cnfrm_new_password"
										id="cnfrm_new_password" placeholder="Re-enter new password"
										ng-model="userdetails.cnfrmnewpassword" required />
								</div>
								<span
									ng-show="form2.cnfrm_new_password.$dirty && form2.cnfrm_new_password.$error.required"
									class="help-block">New Password is required</span>
							</div>


							<div
								ng-if="(userdetails.newpassword != userdetails.cnfrmnewpassword && form2.new_password.$dirty && form2.cnfrm_new_password.$dirty)">
								<span class="text-danger">Password Not Match</span></div>


							<div class="modal-footer" style="margin-top: 20px"
								>
								<input type="submit" ng-click="updatePassword()" value="Save"
									class="btn btn-primary" data-dismiss="modal" ng-disabled="form2.current_password.$error.required || form2.new_password.$error.required || form2.cnfrm_new_password.$error.required || userdetails.password != userdetails.currentpassword || userdetails.newpassword != userdetails.cnfrmnewpassword">
							</div>


						</form>
					</div>
				</div>
			</div>
		</div>



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

<%@ include file="../templates/footer.jsp"%>
</body>
</html>