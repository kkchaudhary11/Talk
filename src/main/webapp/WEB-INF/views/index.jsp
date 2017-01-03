<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%@ include file="../templates/head-meta.jsp"%>


</head>
<body>

	<div class="container">
		<h1>Login</h1>

		<div class="col-md-12" align="right">
		<a href="aboutus" title="About Us"><i
					class="fa fa-info-circle fa-2x" aria-hidden="true"></i></a>
		</div>
		
		
		<div class="col-md-12">
			<div class="col-md-6">

				<c:if test="${param.error != null}">
					<p class="alert alert-danger">
						<span><b>TRY AGAIN!</b> Invalid Email or password.</span>
					</p>
				</c:if>
				<c:if test="${param.logout != null}">
					<p class="alert alert-success">
						<span>You have been logged out successfully.</span>
					</p>
				</c:if>

			</div>
			<div class="col-md-6" >
			</div>
		</div>




		<form action="login" method="post">
			<div class="col-md-6">
				<div class="col-md-6" style="margin-bottom: 20px">
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-user fa-lg"
							aria-hidden="true"></i></span> <input id="msg" type="text"
							class="form-control" name="username" placeholder="Enter email">
					</div>

				</div>
				<div class="col-md-6" style="margin-bottom: 20px">
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-lock fa-lg"
							aria-hidden="true"></i></span> <input type="password"
							class="form-control" name="password" placeholder="Enter password">
					</div>

				</div>
			</div>
			<div class="col-md-6" style="margin-bottom: 20px">
				<div class="col-md-12">
					<input type="submit" value="Log In" class="btn btn-primary" />
				</div>

			</div>
		</form>
	</div>


	<hr />


	<div class="container">
		<h1>Sign Up</h1>
		<br>
		<div class="col-md-6">

			<div>
				<c:if test="${not empty passwordmismatch}">
					<p class="alert alert-danger">
						<b>OOPS!</b>&nbsp Password Does't Match
					</p>
				</c:if>

				<c:if test="${not empty useralreadyexists}">
					<p class="alert alert-danger">
						<b>OOPS!</b>&nbsp Username Already Exists
					</p>
				</c:if>

				<c:if test="${not empty success}">
					<p class="alert alert-success">
						<b>GREAT</b>&nbsp Account Created Successfully
					</p>
				</c:if>
			</div>

			<form:form action="adduser" method="post" modelAttribute="user">

				<div class="input-group">
					<span class="input-group-addon"><i class="fa fa-user fa-lg"
						aria-hidden="true"></i></span>
					<form:input type="text" path="username" class="form-control"
						placeholder="Enter your name" />
				</div>
				<span class="text text-danger"><form:errors path="username" /></span>



				<div class="input-group" style="margin-top: 20px">
					<span class="input-group-addon"><i class="fa fa-envelope "
						aria-hidden="true"></i></span>
					<form:input type="email" class="form-control" path="email"
						placeholder="Enter your email Id" />
				</div>
				<span class="text text-danger"><form:errors path="email" /></span>


				<div class="input-group" style="margin-top: 20px">
					<span class="input-group-addon"><i class="fa fa-lock fa-lg"
						aria-hidden="true"></i></span>
					<form:input type="password" path="password" class="form-control"
						placeholder="Enter your password" />
				</div>
				<span class="text text-danger"><form:errors path="password" /></span>


				<div class="input-group" style="margin-top: 20px">
					<span class="input-group-addon"><i class="fa fa-lock fa-lg"
						aria-hidden="true"></i></span>
					<form:input type="password" path="cpassword" class="form-control"
						placeholder="re-enter your password" />
				</div>

				<div class="input-group" style="margin-top: 20px">
					<span class="input-group-addon"><i
						class="fa fa-map-marker fa-lg" aria-hidden="true"></i></span>
					<form:input type="text" class="form-control" path="city"
						placeholder="Enter your city" />
				</div>

				<div class="input-group" style="margin-top: 20px">
					<span class="input-group-addon"><i class="fa fa-calendar "
						aria-hidden="true"></i></span>
					<form:input type="date" class="form-control" path="dob"
						placeholder="Enter your Date Of Birth" />
				</div>

				<div class="input-group" style="margin-top: 20px">
					<span class="input-group-addon"><i class="fa fa-phone "
						aria-hidden="true"></i></span>
					<form:input type="text" class="form-control" path="phone"
						placeholder="Enter the mobile number" />
				</div>
				<span class="text text-danger"><form:errors path="phone" /></span>

				<div class="input-group" style="margin-top: 20px">
					<label class="radio-inline"> <form:radiobutton
							path="gender" value="Male" />Male

					</label> <label class="radio-inline"> <form:radiobutton
							path="gender" value="Female" />Female
					</label>
				</div>

				<div style="margin-top: 20px">
					<input type="submit" value="Sign Up"
						class="btn btn-success btn-block" />
				</div>

			</form:form>
		</div>

		<div class="col-md-6">
			<img src="resources/images/index_img.jpg" class="img-responsive"
				alt="image" />
		</div>

	</div>

	<%@ include file="../templates/footer.jsp"%>
</body>
</html>