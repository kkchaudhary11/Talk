<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<%@ include file="../templates/head-meta.jsp"%>


</head>
<body>

	<div class="container">
		<h1>Login 	</h1>
		<div align="right">
						<a href="aboutus" title="About Us"><i class="fa fa-info-circle fa-2x" aria-hidden="true"></i></a>
					
					</div>

		<form action="login" method="post">
			<div class="col-md-6">
				<div class="col-md-6" style="margin-bottom: 20px">
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-user fa-lg"
							aria-hidden="true"></i></i></span> <input id="msg" type="text"
							class="form-control" name="username" placeholder="Enter email">
					</div>
				</div>
				<div class="col-md-6" style="margin-bottom: 20px">
					<div class="input-group">
						<span class="input-group-addon"><i class="fa fa-lock fa-lg"
							aria-hidden="true"></i></span> <input id="msg" type="text"
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
		<h1>Sign Up</h1><br>
		<div class="col-md-6">

			<form:form action="adduser" method="post" modelAttribute="user">

			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-user fa-lg"
					aria-hidden="true"></i></span> <form:input type="text" path="username" class="form-control"
					placeholder="Enter your name"/>
			</div>
			<br>

			<div class="input-group">
				<span class="input-group-addon"><i
					class="fa fa-envelope " aria-hidden="true"></i></span> <form:input
					type="email" class="form-control" path="email" placeholder="Enter your email Id" />
			</div>
			<br>
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-lock fa-lg"
					aria-hidden="true"></i></span> <form:input type="password" path="password" class="form-control"
					placeholder="Enter your password" />
			</div>
			<br>
			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-lock fa-lg"
					aria-hidden="true"></i></span> <form:input type="password" path="cpassword" class="form-control"
					placeholder="re-enter your password" />
			</div>
			<br>
			<div class="input-group">
				<span class="input-group-addon"><i
					class="fa fa-map-marker fa-lg" aria-hidden="true"></i></span> <form:input
					type="text" class="form-control" path="city" placeholder="Enter your city" />
			</div>
			<br>
			<div class="input-group">
				<span class="input-group-addon"><i
					class="fa fa-calendar " aria-hidden="true"></i></span> <form:input
					type="date" class="form-control" path="dob"
					placeholder="Enter your Date Of Birth" />
			</div>
			<br>

			<div class="input-group">
				<span class="input-group-addon"><i class="fa fa-phone fa-lg"
					aria-hidden="true"></i></span> <form:input type="text" class="form-control" path="phone"
					placeholder="Enter the mobile number" />
			</div>
			<br>

			<div class="input-group">
				<label class="radio-inline">
				 <form:radiobutton path="gender" value="Male"/>Male

				</label>
				 <label class="radio-inline"> 
				<form:radiobutton path="gender" value="Female"/>Female
				</label>
			</div> 

			<br> <input type="submit" value="Sign Up"
				class="btn btn-success btn-block" />
				
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