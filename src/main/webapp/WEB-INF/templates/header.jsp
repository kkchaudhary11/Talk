<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


	<!-- navigation bar  -->

	<nav class="navbar navbar-default navbar-static-top" role="navigation">
		<div class="container"
			style="padding-top: 10px; padding-bottom: 10px;">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index" style="margin-top: -10px;"><img
					src="${pageContext.request.contextPath}/resources/images/logomin.png"
					alt="logo" width="50" height="50"></a><span
					style="font-size: xx-large; line-height: 60px;">Talk</span>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">


				<ul class="nav navbar-nav navbar-right">
					<li>
					
					<img ng-src="
					${pageContext.request.contextPath}/resources/images/<security:authentication property='principal.username' />.jpg "
						class="img-circle" width="40" height="40"
						style="margin-top: 10px;"
						on-error-src='${pageContext.request.contextPath}/resources/images/user.jpg'
						 onerror="this.src='${pageContext.request.contextPath}/resources/images/user.jpg'"
						width="30" height="30" id="sm_profilepic" />
					
						</li>

					<li><a href="logout" title="logout" class="pull-right"><i
							class="fa fa-power-off fa-2x" aria-hidden="true"></i></a></li>
				</ul>

			</div>
		</div>
	</nav>
