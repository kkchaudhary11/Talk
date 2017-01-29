<!DOCTYPE HTML>
<html lang="en">
<head>
<%@ include file="../templates/head-meta.jsp"%>

<script>
function updateScroll(){
    var element = document.getElementById("test");
    element.scrollTop = element.scrollHeight;
}
</script>
</head>

<body ng-app="chatApp">

	<%@ include file="../templates/header.jsp"%>

	<div ng-controller="ChatCtrl" class="container">
		<div class="col-md-6 col-md-offset-3">
			
			

			<div class="panel panel-primary" >
				<div class="panel-heading">Friend</div>
				<div class="panel-body" style="overflow-y: scroll; height: 350px;" id="test">

					<p ng-repeat="message in messages" class="message well well-sm"
						style="padding: 10px">

						<span ng-class="{self: message.self}" style="font-size: 15px;display: block;">{{message.message}}</span> 
						<span ng-class="{self: message.self}" style="font-size: 10px;display: block;">{{message.time | date:'h:mma'}}</span>

					</p>

				</div>
				<div class="panel-footer">

					<form ng-submit="addMessage()" name="messageForm">

						<div class="input-group">

							<input type="text" placeholder="Compose a new message..." id="inp"
								ng-model="message" class="form-control" autofocus /> <span
								class="input-group-addon count" ng-bind="max - message.length"
								ng-class="{danger: message.length > max}">140</span> <span
								class="input-group-btn">
								<button onclick="setTimeout(updateScroll, 100);"
									ng-disabled="message.length > max || message.length === 0"
									class="btn btn-success">
									<i class="fa fa-paper-plane-o" aria-hidden="true"></i>&nbspSend
								</button>
							</span>
						</div>


					</form>


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
		src="${pageContext.request.contextPath}/resources/references/privatechat/app.js"
		type="text/javascript"></script>
	<script
		src="${pageContext.request.contextPath}/resources/references/privatechat/controllers.js"
		type="text/javascript"></script>
	<script
		src="${pageContext.request.contextPath}/resources/references/privatechat/services.js"
		type="text/javascript"></script>
</body>

<%@ include file="../templates/footer.jsp"%>

</html>
