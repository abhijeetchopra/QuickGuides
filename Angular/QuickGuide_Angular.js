/* -------------------------------------
 * Auth: Abhijeet Chopra
 * Date: Sun Sep 24, 2017
 * Desc: Quick Conda Guide
 * ---------------------------------- */

/* ADDING ANGULAR SCRIPT TO WEBPAGE
------------------------------------- */
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>

/* NG - DIRECTIVES
------------------------------------- */
ng-app    // defines an AngularJS application, only one per web page
         
ng-model  // binds the value of HTML controls (input, select, textarea) to application data
         
ng-bind   // binds application data to the HTML view

ng-init   // initializes AngularJS application variables


/* SAMPLE CODE
------------------------------------- */
<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
<body>

<div ng-app="" ng-init="firstName='John';lastName='Doe';degree='MBA'">

<p>First Name: <input type="text" ng-model="firstName" /></p>
<p>Last Name: <input type="text" ng-model="lastName" /></p>
<p>Degree : <input type="text" ng-model="degree" /></p>


<p>
<span>{{firstName}}</span>
<span> {{lastName}}</span>
<span>, {{degree}}</span>
</p>


<p>
<span>{{firstName + " " + lastName + ", " + degree }}</span>
</p>


<p>
<span ng-bind="firstName"></span>
<span ng-bind="lastName"></span>
<span>, </span>
<span ng-bind="degree"></span>
</p>

<p>
<span ng-bind="firstName + ' ' + lastName + ', ' + degree"></span>
</p>

</div>

</body>
</html>

ng-app directive tells AngularJS that the <div> element is the "owner" of an AngularJS application.

ng-model directive binds the value of the input field to the application variable name.

ng-bind directive binds the innerHTML of the <p> element to the application variable name. 


/* VALID HTML
------------------------------------- */
use data-ng-, instead of ng-, if you want to make your page HTML valid.


/* ANGULAR EXPRESSIONS {{  }}
------------------------------------- */
<div ng-app="">
<p>My first expression: {{ 15 * 2 + 5 }}</p>
</div>


/* ANGULAR JS APPLICATIONS
------------------------------------- */
AngularJS "modules" define AngularJS applications.

AngularJS "controllers" control AngularJS applications.

The "ng-app" directive defines the application, the "ng-controller" directive defines the controller.


/* SAMPLE CODE
------------------------------------- */
// basic angular app
<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
<body>

<p>Try to change the names.</p>

<div ng-app="myApp" ng-controller="myCtrl">

First Name: <input type="text" ng-model="firstName"><br>
Last Name: <input type="text" ng-model="lastName"><br>
<br>
Full Name: {{firstName + " " + lastName}}

</div>

<script>
var app = angular.module('myApp', []);        // module - defines app
app.controller('myCtrl', function($scope) {   // controller - controls app
    $scope.firstName= "John";
    $scope.lastName= "Doe";
});
</script>


<div ng-app="" ng-init="myCol='lightblue'">

<input style="background-color:{{myCol}}" ng-model="myCol" value="{{myCol}}">

</div>

</body>
</html>


/* SAMPLE CODE
------------------------------------- */
// changing inline CSS
<div ng-app="" ng-init="myCol='lightblue'">
<input style="background-color:{{myCol}}" ng-model="myCol" value="{{myCol}}">
</div>



/* SAMPLE CODE
------------------------------------- */
// change color of itself/other elements
<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
<body>

<h3>Change the value of the input fields.</h3>

<div ng-app="" ng-init="m1='lightblue';m2='pink';m3='lightblue';m4='pink'">

Input fields are the model and controller themselves:
<p>
<input style="background-color:{{m1}}" ng-model="m1" value="{{m1}}">
<input style="background-color:{{m2}}" ng-model="m2" value="{{m2}}">
</p>

Input fields control the fields directly below them:
<p>
<input ng-model="m3">
<input ng-model="m4">
</p>

<p>
<input style="background-color:{{m3}}">
<input style="background-color:{{m4}}">
</p>

</div>

</body>
</html>


/* ANGULAR JS OBJECTS
------------------------------------- */
// just like JavaScript objects
<div ng-app="" ng-init="person={firstName:'John',lastName:'Doe'}">

<p>The name is {{ person.lastName }}</p>

</div> 



/* END OF FILE
-------------------------------------- */