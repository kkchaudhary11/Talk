<!DOCTYPE HTML>
<html lang="en">
  <head>
  <%@ include file="../templates/head-meta.jsp"%>
   </head>
  <body ng-app="chatApp">
  
  <%@ include file="../templates/header.jsp"%>
  
    <div ng-controller="ChatCtrl" class="container">
      <form ng-submit="addMessage()" name="messageForm">
      
      <div class="input-group">
    
    <input type="text" placeholder="Compose a new message..." ng-model="message" class="form-control" />
    <span class="input-group-addon" ng-bind="max - message.length" ng-class="{danger: message.length > max}">140</span>
     <span class="input-group-btn">
     <button ng-disabled="message.length > max || message.length === 0" class="btn btn-success"><i class="fa fa-paper-plane-o" aria-hidden="true"></i>&nbspSend</button></span>
 		 </div>
      
        
      </form>
      <hr />
      <p ng-repeat="message in messages | orderBy:'time':true" >
        <b>{{message.time | date:'HH:mm'}}</b>
        <span ng-class="{self: message.self}">{{message.message}}</span>
      </p>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/0.3.4/sockjs.min.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.8/angular.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/2.4.1/lodash.js"></script>
    <script src="${pageContext.request.contextPath}/resources/references/js/app.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/references/js/controllers.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/resources/references/js/services.js" type="text/javascript"></script>
  </body>
</html>
