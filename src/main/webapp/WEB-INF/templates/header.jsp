<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!-- navigation bar  -->

<nav class="navbar navbar-default navbar-static-top" role="navigation">
	<div class="container" style="padding-top: 10px; padding-bottom: 10px;">
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

				<li><img
					ng-src="
					${pageContext.request.contextPath}/resources/images/<security:authentication property='principal.username' />.jpg "
					class="img-circle" width="40" height="40" style="margin-top: 10px;"
					on-error-src='${pageContext.request.contextPath}/resources/images/user.jpg'
					onerror="this.src='${pageContext.request.contextPath}/resources/images/user.jpg'"
					width="30" height="30" id="sm_profilepic" /></li>

				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"><i
						class="fa fa-caret-down fa-2x" aria-hidden="true"></i></a>
					<ul class="dropdown-menu">
						<li><a href="viewblogs"> <img
								src="${pageContext.request.contextPath}/resources/images/blog.png"
								alt="logo" width="20" height="20">&nbsp <b>Blog</b>
						</a></li>
						<li><a href="allusers"><img
								src="${pageContext.request.contextPath}/resources/images/people.png"
								alt="logo" width="20" height="20">&nbsp <b>Peoples</b></a></li>
						<li><a href="friends"><img
								src="${pageContext.request.contextPath}/resources/images/friend.png"
								alt="logo" width="20" height="20">&nbsp <b>Friends</b></a></li>
						<li><a href="talk"><img
								src="${pageContext.request.contextPath}/resources/images/group-chat.png"
								alt="logo" width="20" height="20">&nbsp <b>Group Chat</b></a>
						</li>
					</ul></li>


				<li><a href="logout" title="logout" class="pull-right"><i
						class="fa fa-power-off fa-2x" aria-hidden="true"></i></a></li>
			</ul>

		</div>
	</div>
</nav>
