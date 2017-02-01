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

	myApp.factory("EventService", [
			"$http",
			"$q",
			function($http, $q) {
				var BASE_URL = 'http://localhost:9999/Talk/';

				return {

					postEvent : function(item) {
						return $http.post(BASE_URL + 'admin/postevent', item).then(
								function(response) {
									return response.data;
								}, function(errResponse) {
									console.error('Error while sending data');
									return $q.reject(errResponse);
								});
					},

					getEvents : function() {
						return $http.get(BASE_URL + 'viewevents').then(
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
			"EventService",
			function($scope, $EventService) {

				// post the blog

				$scope.postEvent = function() {

					console.log("in the post blog");
					$scope.eventInfo = {
						EventTitle : $scope.user.eventTitle,
						EventDesc : $scope.user.eventDesc,
					};

					$EventService.postEvent($scope.eventInfo).then(
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

				//list events

				$EventService.getEvents().then(function(response) {
					$scope.events = response;
					console.log($scope.events);
				}, function(errResponse) {
					console.log('Error fetching Events');
				});

			} ]);
</script>


<body ng-app="myApp" ng-controller="myCtrl">

	<%@ include file="../templates/header.jsp"%>

	<div class="container">

		<div ng-show="status">
			<p class="alert alert-info">
				<b>Success!</b>&nbsp{{status}}<br />
			</p>
		</div>

		<security:authorize access="hasRole('ROLE_ADMIN')">

			<div class=col-md-12>
				<div class="col-md-4 col-md-offset-4">
					<button type="button" class="btn btn-success btn-block"
						data-toggle="modal" data-target="#myEvent">Create Event</button>
				</div>
			</div>

			<!-- Modal for cerate event -->
			<div class="modal fade" id="myEvent" role="dialog">
				<div class="modal-dialog modal-md">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Create Event</h4>
						</div>
						<div class="modal-body">
							<form name="event" action="#">

								<div class="form-group"
									ng-class="{ 'has-error': event.title.$dirty && event.title.$error.required }">

									<div class="input-group" style="margin-top: 20px">
										<span class="input-group-addon"><i class="fa fa-pencil"
											aria-hidden="true"></i></span> <input type="text"
											class="form-control" name="title" id="title"
											placeholder="Enter title" ng-model="user.eventTitle" required>

									</div>
									<span ng-show="event.title.$dirty && event.title.$error.required"
										class="help-block">Required</span>
								</div>


								<div class="form-group"
									ng-class="{ 'has-error': event.my_blog.$dirty && event.my_blog.$error.required }">

									<div class="input-group" style="margin-top: 20px">
										<span class="input-group-addon"><i
											class="fa fa-pencil-square-o" aria-hidden="true"></i></span>
										<textarea rows="7" class="form-control" name="my_event"
											id="my_event" placeholder="Enter Description"
											ng-model="user.eventDesc" required></textarea>
									</div>
									<span
										ng-show="event.my_blog.$dirty && event.my_blog.$error.required"
										class="help-block">Required</span>
								</div>

								<div class="modal-footer" style="margin-top: 20px">
									<input type="submit" ng-click="postEvent()" value="Post"
										class="btn btn-primary" data-dismiss="modal"
										ng-disabled="event.my_event.$error.required || event.event.$error.required">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

		</security:authorize>
		
		<br>
		<h2>Events</h2>
		<div>
			<div class="panel-group" ng-show="events">
				<div class="panel panel-default" ng-repeat="event in events | orderBy:'eventdate':true"
					style="margin-top: 40px">

					<div class="panel-body">
						<h3>{{event.title}}</h3>
						<hr />
						<p style="text-align: justify">{{event.description}}</p>
						<hr />
						<h5>
							<b>POSTED ON:</b> &nbsp{{event.postdate | date:"dd/MM/yyyy"}}
						</h5>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../templates/footer.jsp"%>
</body>
</html>