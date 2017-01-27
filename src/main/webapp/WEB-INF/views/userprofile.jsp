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

<script>
	var myApp = angular.module("myApp", []);

	//default profile picture
	myApp.directive('onErrorSrc', function() {
		return {

			link : function(scope, element, attrs) {

				element.bind('error', function() {

					if (attrs.src != attrs.onErrorSrc) {
						attrs.$set('src', attrs.onErrorSrc);
						//disable the delete profile picture button when there is no image
						scope.picDeleted = true;
						scope.$apply();

					}
				});
			}
		}
	});

	///////////////////////////////////////

	myApp.service('fileUpload', [ '$http', function($http) {
		this.uploadFileToUrl = function(file, paramuser, uploadUrl) {
			var fd = new FormData();
			fd.append('file', file);
			//fd.append('user','vasudev89');
			return $http.post(uploadUrl, fd, {
				transformRequest : angular.identity,
				headers : {
					'Content-Type' : undefined,
					user : paramuser
				}
			}).then(function(response) {
				return response.data;
			}, function(errResponse) {
				console.error('Error while updating User');
				return "error";
			});
		}
	} ]);

	///////////////////////////////////////

	myApp.factory("UserService", [
			"$http",
			"$q",
			function($http, $q) {
				var BASE_URL = 'http://localhost:9999/Talk/';

				return {

					userData : function() {

						return $http.get(BASE_URL + 'userdata').then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									return $q.reject(errResponse);
								});
					},

					updateUser : function(item) {
						return $http.post(BASE_URL + 'updateuser', item).then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									console.error('Error while sending data');
									return $q.reject(errResponse);
								});
					},

					deleteUser : function(item) {
						return $http.post(BASE_URL + 'deleteuser', item).then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									console.error('Error while sending data');
									return $q.reject(errResponse);
								});
					},

					updatePassword : function(item) {
						return $http.post(BASE_URL + 'updatepassword', item)
								.then(function(response) {
									return response.data;
								}, function(errResponse) {
									console.error('Error while sending data');
									return $q.reject(errResponse);
								});
					},

					deleteUserImage : function(item) {
						return $http.post(BASE_URL + 'deleteUserImage', item)
								.then(function(response) {
									return response.data;
								}, function(errResponse) {
									console.error('Error while updating User');
									return $q.reject(errResponse);
								});

					},

					getAllUsers : function() {
						return $http.get(BASE_URL + 'admin/allusers').then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									return $q.reject(errResponse);
								});
					},

				/* 	postBlog : function(item) {
						return $http.post(BASE_URL + 'postblog', item).then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									console.error('Error while sending data');
									return $q.reject(errResponse);
								});
					},
					
					getAllBlogs : function() {
						return $http.get(BASE_URL + 'admin/allblogs').then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									return $q.reject(errResponse);
								});
					},
					

					publishBlog : function(item) {
						return $http.post(BASE_URL + 'publishblog', item).then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									console.error('Error while sending data');
									return $q.reject(errResponse);
								});
					}
					,
					
					getBlogs : function() {
						return $http.get(BASE_URL + 'blogs').then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									return $q.reject(errResponse);
								});
					} */

				};
			} ]);

	myApp
			.controller(
					"myCtrl",
					[
							"$scope",
							"$filter",
							"UserService",
							"fileUpload",
							function($scope, $filter, $UserService, $fileUpload) {

								var date = new Date();
								$scope.time = $filter('date')(new Date(), 'HH');

								//get user data when page loads

								$UserService
										.userData()
										.then(
												function(response) {
													//console.log(response);
													$scope.userdetails = response;
													//load profile picture when page loads after the userdetails get fatched
													$scope.userdetails.Image = '${pageContext.request.contextPath}/resources/images/'
															+ $scope.userdetails.email
															+ '.jpg';
												},
												function(errResponse) {
													console
															.log('Error fetching User Details');
												});

								//update user data							

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
															$scope.status = response.status;
														} catch (e) {
															$scope.data = [];
														}
													},
													function(errResponse) {
														console
																.error('Error while Sending Data.');
													});
								}

								//delete user [ADMIN]

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

								//update password

								$scope.updatePassword = function() {

									console
											.log("in the update password update");

									$UserService
											.updatePassword(
													$scope.userdetails.newpassword)
											.then(
													function(response) {
														try {
															$scope.status = response.status;
														} catch (e) {
															$scope.data = [];
														}

													},
													function(errResponse) {
														console
																.error('Error while Sending Data.');
													});

								}

								//list all users [ADMIN]

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

								// open File Explorer for seleting file/image

								$scope.openFileChooser = function() {
									$('#trigger').trigger('click');
								};

								$scope.picUpdated = false;
								$scope.picUpdatedWithError = false;
								$scope.invalidPicType = false;
								/* $scope.picDeleted = false;  */

								// delete profile image
								$scope.DeletePic = function() {

									var resp = $UserService
											.deleteUserImage(
													$scope.userdetails.email)
											.then(
													function(response) {

														$scope.status = response.status;

														if ($scope.status == "PICTURE DELETED") {
															$scope.picDeleted = true;
															$scope.userdetails.Image = null;
															document
																	.getElementById("profilepic").src = '';
															document
																	.getElementById("sm_profilepic").src = '';

														} else {
															$scope.picUpdatedWithError = true;
														}
													},
													function(errResponse) {
														console
																.error('Error while Updating User.');
													});
								}

								// Upload image 

								$scope.setFile = function(element) {

									$scope.currentFile = element.files[0];

									var reader = new FileReader();
									reader.onload = function(event) {
										$scope.userdetails.Image = event.target.result
										$scope.$apply()
									};
									// when the file is read it triggers the onload event above.
									reader.readAsDataURL($scope.currentFile);

									var file = $scope.currentFile;
									console.log('file is :');
									console.dir(file);
									var uploadUrl = "http://localhost:9999/Talk/updateProfilePicture/";
									// calling uploadFileToUrl function of $fileUpload
									var res = $fileUpload
											.uploadFileToUrl(file,
													$scope.userdetails.email,
													uploadUrl)
											.then(
													function(response) {
														$scope.status = response.status;
														$scope.imagesrc = response.imagesrc;
														$scope.picDeleted = false;

														//console.log( $scope.response );
														//console.log( $scope.imagesrc );

														$scope.currentImage = '${pageContext.request.contextPath}/'
																+ $scope.imagesrc;

														$scope.stateDisabled = false;

													},

													function(errResponse) {
														console
																.error('Error while Updating User.');
													});

								};

								

							} ]);
</script>


<body ng-app="myApp" ng-controller="myCtrl">


	<%@ include file="../templates/header.jsp"%>

	<div class="container">

		<div class="col-md-3">
			

			<div>
				<div ng-if="time<12">
					<img alt="good morning"
						ng-src="${pageContext.request.contextPath}/resources/images/morning.jpg"
						width="50" height="50"> Good Morning
				</div>

				<div ng-if="time>=12 && time<=17">
					<img alt="good morning"
						ng-src="${pageContext.request.contextPath}/resources/images/afternoon.jpg"
						width="50" height="50"> Good Afternoon
				</div>

				<div ng-if="time>17 && time<24">
					<img alt="good morning"
						ng-src="${pageContext.request.contextPath}/resources/images/evening.jpg"
						width="50" height="50"> <span class="text-muted">Good
						Evening</span>
				</div>
			</div>
		</div>




		<div class="col-md-3 text-center">
			<div ng-if="userdetails.gender == 'Male'">

				<img ng-src="{{userdetails.Image}}" width="150" height="150"
					id="profilepic"
					onerror="this.src='${pageContext.request.contextPath}/resources/images/male_dummy.jpg'">
			</div>
			<div ng-if="userdetails.gender == 'Female'">
				<img ng-src="{{userdetails.Image}}" width="150" height="150"
					id="profilepic"
					onerror="this.src='${pageContext.request.contextPath}/resources/images/female_dummy.jpg'">
			</div>




			<div>
				<button type="button" class="btn btn-link"
					ng-click="openFileChooser();">Change Picture</button>

				<input type="file" id="trigger" ng-show="false"
					onchange="angular.element(this).scope().setFile(this)"
					accept="image/*" file-model="myFile" />


				<button ng-click="DeletePic();" class="btn btn-danger btn-sm"
					title="delete picture" ng-disabled="picDeleted">
					<i class="fa fa-trash-o fa-1x" aria-hidden="true"></i>
				</button>




			</div>



		</div>

		<div class="col-md-3 text-center">


			<div style="display: inline-block;">

				<div style="text-align: left">
				
				<div ng-hide="userdetails">
				<i class="fa fa-circle-o-notch fa-spin fa-3x fa-fw"></i> <span
					class="sr-only">Loading...</span>
			</div>
					<div>
						<span style="font-size: xx-large;">
							{{userdetails.username}}</span>
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
						<i class="fa fa-venus" aria-hidden="true"></i> &nbsp
						{{userdetails.gender}}
					</div>

					<div ng-show="status">
						<p class="alert alert-info">
							<i class="fa fa-check-circle" aria-hidden="true"></i>&nbsp
							&nbsp{{status}}<br />
						</p>
					</div>

				</div>
			</div>
		</div>


		<div class="col-md-3">
			<button type="button" class="btn btn-default btn-sm"
				data-toggle="modal" data-target="#myModal2">Change Password</button>
			<br /> <br />

			<button type="button" class="btn btn-default btn-sm"
				data-toggle="modal" data-target="#myModal">Update Info</button>

		</div>



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
										type="password" class="form-control" name="current_password"
										id="current_password" placeholder="Enter current password"
										ng-model="userdetails.currentpassword" required />
								</div>
								<span
									ng-show="form2.current_password.$dirty && form2.current_password.$error.required"
									class="help-block">Current Password is required</span>
							</div>

							<div
								ng-if="(userdetails.password != userdetails.currentpassword && form2.current_password.$dirty)">
								<span class="text-danger">Password is Incorrect</span>
							</div>


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
								<span class="text-danger">Password Not Match</span>
							</div>


							<div class="modal-footer" style="margin-top: 20px">
								<input type="submit" ng-click="updatePassword()" value="Save"
									class="btn btn-primary" data-dismiss="modal"
									ng-disabled="form2.current_password.$error.required || form2.new_password.$error.required || form2.cnfrm_new_password.$error.required || userdetails.password != userdetails.currentpassword || userdetails.newpassword != userdetails.cnfrmnewpassword">
							</div>


						</form>
					</div>
				</div>
			</div>
		</div>



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


							<div class="modal-footer" style="margin-top: 20px">
								<input type="submit" ng-click="updateUser()" value="Save"
									class="btn btn-primary" data-dismiss="modal"
									ng-disabled="form.username.$dirty && form.username.$error.required">
							</div>

						</form>
					</div>
				</div>
			</div>
		</div>




	</div>

	<hr />

	<div class="container">
		<div class="col-md-4 " style="margin-top: 30px">


			<a href="viewblogs" class="btn btn-success btn-block btn-outline">
				<img
				src="${pageContext.request.contextPath}/resources/images/blog.png"
				alt="logo" width="40" height="40">&nbsp <b>Blog</b>
			</a>
		</div>
		<div class="col-md-4" style="margin-top: 30px">

			<a href="allusers" class="btn btn-success btn-block btn-outline"><img
				src="${pageContext.request.contextPath}/resources/images/people.png"
				alt="logo" width="50" height="40">&nbsp <b>Peoples</b></a>
		</div>
		<div class="col-md-4" style="margin-top: 30px">

			<a href="friends" class="btn btn-success btn-block btn-outline"><img
				src="${pageContext.request.contextPath}/resources/images/friend.png"
				alt="logo" width="50" height="40">&nbsp <b>Friends</b></a>
		</div>
		
			<div class="col-md-4" style="margin-top: 30px">

			<a href="talk" class="btn btn-success btn-block btn-outline"><img
				src="${pageContext.request.contextPath}/resources/images/group-chat.png"
				alt="logo" width="40" height="40">&nbsp <b>Group Chat</b></a>
		</div>
		
		
	</div>

	<div class="container">

		<security:authorize access="hasRole('ROLE_ADMIN')">
		<div>
				<h3>
					<i class="fa fa-user-secret" aria-hidden="true"></i>&nbsp
					{{userdetails.role}}
				</h3>

				<button ng-click="getAllUsers()" class="btn btn-success">Get
					All Users</button>


				<!-- <button ng-click="getAllBlogs()" class="btn btn-primary">Get
				All Blogs</button> -->


				<table class="table" ng-show="allusers">
					<caption>
						<h3>USERS</h3>
					</caption>

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

						</tr>

					</tbody>
				</table>

			</div>

		</security:authorize>

		<div>

		</div>




	</div>

	<%@ include file="../templates/footer.jsp"%>
</body>
</html>