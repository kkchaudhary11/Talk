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

	myApp.factory("JobService", [
			"$http",
			"$q",
			function($http, $q) {
				var BASE_URL = 'http://localhost:9999/Talk/';

				return {

					postJob : function(item) {
						return $http.post(BASE_URL + 'admin/postjob', item).then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									console.error('Error while sending data');
									return $q.reject(errResponse);
								});
					},
					
					
					applyJob : function(item) {
						return $http.get(BASE_URL + 'applyjob/'+item).then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									console.error('Error while sending data');
									return $q.reject(errResponse);
								});
					},

					getJobs : function() {
						return $http.get(BASE_URL + 'viewjobs').then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									return $q.reject(errResponse);
								});
					},
					
					jobsUserApplied : function() {
						return $http.get(BASE_URL + 'viewjobapplied').then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									return $q.reject(errResponse);
								});
					}

				};
			} ]);

	myApp.controller("myCtrl", [
			"$scope",
			"JobService",
			function($scope, $JobService) {

				// post the job [ADMIN]

				$scope.postJob = function() {

					console.log("in the post job");
					$scope.JobInfo = {
						JobTitle : $scope.user.jobTitle,
						JobQual : $scope.user.jobQual,
						JobDesc : $scope.user.jobDesc,
					};

					$JobService.postJob($scope.JobInfo).then(
							function(response) {
								try {
									$scope.status = response.status;
								} catch (e) {
									$scope.data = [];
								}

							}, function(errResponse) {
								console.error('Error while Sending Data.');
							});

				}
				
				//apply for a  job
				
				$scope.applyJob = function(jobId) {

					console.log("in the apply job");
					$JobService.applyJob(jobId).then(
							function(response) {
								try {
									$scope.status = response.status;
								} catch (e) {
									$scope.data = [];
								}

							}, function(errResponse) {
								console.error('Error while Sending Data.');
							});

				}
				
				//view  jobs user applied [ADMIN]
				
				$scope.jobsUserApplied = function() {

					console.log("in the jobs user apply");
					$JobService.jobsUserApplied().then(
							function(response) {
								try {
									$scope.users = response;
								} catch (e) {
									$scope.data = [];
								}

							}, function(errResponse) {
								console.error('Error while Sending Data.');
							});

				}

				//list jobs on page-load

				$JobService.getJobs().then(function(response) {

					$scope.jobs = response;
				}, function(errResponse) {
					console.log('Error fetching Users');
				});

			} ]);
</script>


<body ng-app="myApp" ng-controller="myCtrl">

	<%@ include file="../templates/header.jsp"%>

	<div class="container">

		

		<security:authorize access="hasRole('ROLE_ADMIN')">

			<div class=col-md-12>
				<div class="col-md-4 col-md-offset-4">
					<button type="button" class="btn btn-success btn-block"
						data-toggle="modal" data-target="#myJob">Create Job</button>
						
					
					<button type="button" class="btn btn-success btn-block"
						 ng-click="jobsUserApplied()">View Applied Users</button>
				</div>
				
			</div>
			
			<div class="col-md-12" style="margin-top:10px">
			<div ng-repeat="user in users" >
			<p class="well well-sm">
			<span><b>{{user.userId.username}}</b></span>
			<span><i>({{user.userId.email}})</i></span>
			<span><i>[PH.{{user.userId.phone}}]</i></span>
			<b>Applied For </b>
			<span>{{user.jobId.title}}</span>
			</p>
			</div>
			</div>

			<!-- Modal for cerate job -->
			<div class="modal fade" id="myJob" role="dialog">
				<div class="modal-dialog modal-md">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Create Job</h4>
						</div>
						<div class="modal-body">
							<form name="job" action="#">

								<div class="form-group"
									ng-class="{ 'has-error': job.title.$dirty && job.title.$error.required }">

									<div class="input-group" style="margin-top: 20px">
										<span class="input-group-addon"><i class="fa fa-pencil"
											aria-hidden="true"></i></span> <input type="text"
											class="form-control" name="title" id="title"
											placeholder="Enter title" ng-model="user.jobTitle" required>

									</div>
									<span ng-show="job.title.$dirty && job.title.$error.required"
										class="help-block">Required</span>
								</div>
								
								<div class="form-group"
									ng-class="{ 'has-error': job.qual.$dirty && job.qual.$error.required }">

									<div class="input-group" style="margin-top: 20px">
										<span class="input-group-addon"><i class="fa fa-graduation-cap" aria-hidden="true"></i></span>
										<textarea rows="3" class="form-control" name="qual" id="qual"
											placeholder="Enter Qualification" ng-model="user.jobQual"
											required></textarea>
									</div>
									<span ng-show="job.qual.$dirty && blog.qual.$error.required"
										class="help-block">Required</span>
								</div>


								<div class="form-group"
									ng-class="{ 'has-error': job.desc.$dirty && job.desc.$error.required }">

									<div class="input-group" style="margin-top: 20px">
										<span class="input-group-addon"><i
											class="fa fa-pencil-square-o" aria-hidden="true"></i></span>
										<textarea rows="7" class="form-control" name="desc" id="desc"
											placeholder="Enter Description" ng-model="user.jobDesc"
											required></textarea>
									</div>
									<span ng-show="job.desc.$dirty && blog.desc.$error.required"
										class="help-block">Required</span>
								</div>

								<div class="modal-footer" style="margin-top: 20px">
									<input type="submit" ng-click="postJob()" value="Post"
										class="btn btn-primary" data-dismiss="modal"
										ng-disabled="job.desc.$error.required">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<br/>
		

		</security:authorize>

		<br>
		<h2>Jobs</h2>
		<div>
			<div class="panel-group" ng-show="jobs">
				<div class="panel panel-default"
					ng-repeat="job in jobs"
					style="margin-top: 40px">

					<div class="panel-body">
						<h3>{{job.title}}</h3>
						<hr />
						<span><b>Qualifications:</b>&nbsp {{job.qualification}}</span>
						<p style="text-align: justify"> <b>Description:</b>&nbsp {{job.description}}</p>
						<hr />
						<h5>
							
							<b>Posted on:</b> &nbsp{{job.postdate | date:"MM/dd/yyyy" }}
							<button class="btn btn-primary pull-right" ng-Click="applyJob(job.jobId);">Apply</button>
						</h5>
						<div ng-show="status">
							<p class="alert alert-info">
								<b>Success!</b>&nbsp{{status}}<br />
							</p>
						</div>
					</div>					
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../templates/footer.jsp"%>
</body>
</html>