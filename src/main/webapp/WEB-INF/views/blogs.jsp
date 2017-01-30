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

	myApp.factory("BlogService", [
			"$http",
			"$q",
			function($http, $q) {
				var BASE_URL = 'http://localhost:9999/Talk/';

				return {

					postBlog : function(item) {
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
					},

					unpublishBlog : function(item) {
						return $http.post(BASE_URL + 'unpublishblog', item)
								.then(function(response) {
									return response.data;
								}, function(errResponse) {
									console.error('Error while sending data');
									return $q.reject(errResponse);
								});
					},

					getBlogs : function() {
						return $http.get(BASE_URL + 'blogs').then(
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
			"BlogService",
			function($scope, $BlogService) {

				// post the blog

				$scope.postBlog = function() {

					console.log("in the post blog");
					$scope.UserBlog = {
						BlogTitle : $scope.user.blogTitle,
						BlogDesc : $scope.user.blogDesc,
					};

					$BlogService.postBlog($scope.UserBlog).then(
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

				//list all blogs [ADMIN]

				$scope.getAllBlogs = function() {
					$BlogService.getAllBlogs().then(function(response) {

						$scope.allblogs = response;
					}, function(errResponse) {
						console.log('Error fetching Users');
					});
				}

				//publish blog [ADMIN]

				$scope.publishBlog = function(blogId) {
					console.log(blogId);

					$BlogService.publishBlog(blogId).then(function(response) {

						$scope.status = response.status;
					}, function(errResponse) {
						console.log('Error fetching Users');
					});
				}

				//unpublish blog [ADMIN]

				$scope.unpublishBlog = function(blogId) {
					console.log(blogId);

					$BlogService.unpublishBlog(blogId).then(function(response) {

						$scope.status = response.status;
					}, function(errResponse) {
						console.log('Error fetching Users');
					});
				}

				//list blogs

				$BlogService.getBlogs().then(function(response) {

					$scope.blogs = response;
				}, function(errResponse) {
					console.log('Error fetching Users');
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

		<security:authorize access="hasRole('ROLE_USER')">

			<div class=col-md-12>
				<div class="col-md-4 col-md-offset-4">
					<button type="button" class="btn btn-success btn-block"
						data-toggle="modal" data-target="#myBlog">Create Blog</button>
				</div>
			</div>

			<!-- Modal for cerate blog -->
			<div class="modal fade" id="myBlog" role="dialog">
				<div class="modal-dialog modal-md">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
							<h4 class="modal-title">Create Blog</h4>
						</div>
						<div class="modal-body">
							<form name="blog" action="#">

								<div class="form-group"
									ng-class="{ 'has-error': blog.title.$dirty && blog.title.$error.required }">

									<div class="input-group" style="margin-top: 20px">
										<span class="input-group-addon"><i class="fa fa-pencil"
											aria-hidden="true"></i></span> <input type="text"
											class="form-control" name="title" id="title"
											placeholder="Enter title" ng-model="user.blogTitle" required>

									</div>
									<span ng-show="blog.title.$dirty && blog.title.$error.required"
										class="help-block">Required</span>
								</div>


								<div class="form-group"
									ng-class="{ 'has-error': blog.my_blog.$dirty && blog.my_blog.$error.required }">

									<div class="input-group" style="margin-top: 20px">
										<span class="input-group-addon"><i
											class="fa fa-pencil-square-o" aria-hidden="true"></i></span>
										<textarea rows="7" class="form-control" name="my_blog"
											id="my_blog" placeholder="Enter Description"
											ng-model="user.blogDesc" required></textarea>
									</div>
									<span
										ng-show="blog.my_blog.$dirty && blog.my_blog.$error.required"
										class="help-block">Required</span>
								</div>

								<div class="modal-footer" style="margin-top: 20px">
									<input type="submit" ng-click="postBlog()" value="Post"
										class="btn btn-primary" data-dismiss="modal"
										ng-disabled="blog.my_blog.$error.required || blog.title.$error.required">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>

		</security:authorize>
		<security:authorize access="hasRole('ROLE_ADMIN')">

			<div>

				<%-- <security:authorize access="isAuthenticated()">
   	 authenticated as <security:authentication property="principal.username" /> 
		</security:authorize> --%>

				<div class=col-md-12>
					<div class="col-md-4 col-md-offset-4">
						<button ng-click="getAllBlogs()" class="btn btn-success btn-block">Admin
							Blog Operations</button>
					</div>
				</div>


				<h2 ng-show="allblogs">Approve Blogs</h2>

				<div class="panel-group" ng-show="allblogs">
					<div class="panel panel-default" ng-repeat="blog in allblogs | orderBy:'blogdate':true"
						style="margin-top: 40px">

						<div class="panel-body">
							<h3>{{blog.title}}</h3>
							<hr />
							<p style="text-align: justify">{{blog.description}}</p>
							<hr />
							<h5>
								<b>Posted By:</b> {{blog.userId.username}}
								({{blog.userId.email}}) <b>On</b> {{blog.blogdate}}
							</h5>
							<b>Is Published:</b> <i>{{blog.posted}}</i>
							<div class="pull-right">
								<a href="#" ng-click="publishBlog(blog.blogId)"><i
									class="fa fa-check fa-2x" aria-hidden="true" title="Publish"></i></a>&nbsp
								<a href="#" ng-click="unpublishBlog(blog.blogId)"><i
									class="fa fa-times fa-2x" aria-hidden="true" title="Unpublish"></i></a>
							</div>
						</div>
					</div>
				</div>
			</div>

		</security:authorize>
		<br>
		<h2>Blogs</h2>
		<div>
			<div class="panel-group" ng-show="blogs">
				<div class="panel panel-default" ng-repeat="blog in blogs | orderBy:'blogdate':true"
					style="margin-top: 40px">

					<div class="panel-body">
						<h3>{{blog.title}}</h3>
						<hr />
						<p style="text-align: justify">{{blog.description}}</p>
						<hr />
						<h5>
							<b>Posted By:</b> {{blog.userId.username}} <b>On</b>
							{{blog.blogdate}}
						</h5>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@ include file="../templates/footer.jsp"%>
</body>
</html>