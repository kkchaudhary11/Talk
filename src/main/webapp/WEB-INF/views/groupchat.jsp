<!DOCTYPE HTML>
<html lang="en">
<head>
<%@ include file="../templates/head-meta.jsp"%>
</head>
<body ng-app="chatApp">

	<%@ include file="../templates/header.jsp"%>

	<div ng-controller="ChatCtrl" class="container">
	<h2 style="color:#00a652"><img
				src="${pageContext.request.contextPath}/resources/images/group-chat.png"
				alt="logo" width="30" height="30">&nbsp Group Talk</h2>
		<div class="col-md-6 col-md-offset-3">
			<form ng-submit="addMessage()" name="messageForm">

				<div class="input-group">

					<input type="text" placeholder="Compose a new message..."
						ng-model="message" class="form-control"  autofocus/> <span
						class="input-group-addon count" ng-bind="max - message.length"
						ng-class="{danger: message.length > max}">140</span> <span
						class="input-group-btn">
						<button ng-disabled="message.length > max || message.length === 0"
							class="btn btn-success">
							<i class="fa fa-paper-plane-o" aria-hidden="true"></i>&nbspSend
						</button>
					</span>
				</div>


			</form>
			<hr />

			<div class="panel panel-primary">
				<div class="panel-heading">Conversation</div>
				<div class="panel-body" style="overflow-y: scroll; height: 350px;">

					<p ng-repeat="message in messages | orderBy:'time':true"
						class="message well well-sm" style="padding:10px" >
						<span class="pull-right">{{message.time | date:'h:mma'}}</span>
						<span ng-class="{test: message.self}" style="font-size:15px">{{message.message}}</span><br />
						<span ng-hide="message.self">SEND BY : {{message.username}}</span>
					</p>

				</div>
			</div>
		</div>
	</div>

	<script
		src="${pageContext.request.contextPath}/resources/references/js/sockjs.min.js"
		type="text/javascript"></script>
	<script
		src="${pageContext.request.contextPath}/resources/references/js/stomp.min.js"
		type="text/javascript"></script>
	<script
		src="${pageContext.request.contextPath}/resources/references/js/lodash.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/references/groupchat/app.js"
		type="text/javascript"></script>
	<script
		src="${pageContext.request.contextPath}/resources/references/groupchat/controllers.js"
		type="text/javascript"></script>
	<script
		src="${pageContext.request.contextPath}/resources/references/groupchat/services.js"
		type="text/javascript"></script>
</body>

<%@ include file="../templates/footer.jsp"%>

</html>
