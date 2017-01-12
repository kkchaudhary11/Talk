<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if
	test="${pageContext.request.requestURI eq '/Talk/WEB-INF/views/index.jsp'}">

	<h1>
		Login <a href="aboutus" title="About Us" style="float: right"><i
			class="fa fa-info-circle " aria-hidden="true"></i></a>
	</h1>
	<br>

</c:if>

<c:if
	test="${pageContext.request.requestURI eq '/Talk/WEB-INF/views/aboutus.jsp'}">

	<h1>
		About Us <a href="index" title="Home" style="float: right"><i
			class="fa fa-home" aria-hidden="true"></i></a>
	</h1>

</c:if>

<c:if
	test="${pageContext.request.requestURI eq '/Talk/WEB-INF/views/userprofile.jsp'}">

<img alt="logo" src="resources/images/logo.png" width="80" hight="50">
	<a href="logout" title="logout" class="pull-right"><i class="fa fa-power-off fa-2x" aria-hidden="true"></i></a>

</c:if>