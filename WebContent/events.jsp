<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home</title>
	
	<link rel="stylesheet" href="bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="fontawesome/css/all.min.css">
	<link rel="stylesheet" href="css/index.css">
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	<link rel="manifest" href="site.webmanifest">

	<%
		boolean loggedIn = false;
		// check if logged in
	%> 
</head>
<body onload="loadEvents()">
	<div class="container-fluid p-0 d-flex flex-column h-100">
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	       	<a class="navbar-brand font-weight-bold" href="index.jsp">Play</a>
	       	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	   			<span class="navbar-toggler-icon"></span>
	 		</button>
	 			
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<div class="ml-auto d-flex align-items-center">
	  				<form class="text-white" action="CitySearchServlet" method="POST">
						<div class="input-group">
							<input type="text" class="form-control" name="city" placeholder="Los Angeles">
							<div class="input-group-append">
								<button class="input-group-text fas fa-search" type="submit"></button>
							</div>
						</div>
					</form>
				</div>
				<ul class="navbar-nav ml-auto">
				<% if(loggedIn) { %>
	   				<li class="nav-item">
	     				<a class="nav-link" href="#">Profile</a>
	   				</li>
	   				<li class="nav-item">
	     				<a class="nav-link" href="#">Logout</a>
	   				</li>
	   			<% } else { %>
	   				<li class="nav-item">
	     				<a class="nav-link" href="#">Login</a>
	   				</li>
	   				<li class="nav-item">
	     				<a class="nav-link" href="#">Register</a>
	   				</li>
	   			<% } %>
	   			</ul>
			</div>
	   	</nav>
	
		<div id="map" class="flex-grow-1"></div>
	</div>

	<script src="jquery/jquery-3.3.1.min.js"></script>
	<script src="bootstrap/bootstrap.bundle.min.js"></script>
	<script>
			var map;
			var JSONString;
			var events;
			function loadEvents() {
				$
						.ajax({
							url : "EventsServlet",
							data : {
								
							},
							success : function(result) {
								console.log(result);
								if (result === "") {

								} else {
									JSONString = result;
									events = JSON.parse(JSONString);
									//document.getElementById('errorMessage').innerHTML = events;
									
									var myLatLng = {
											lat : 38.6446543,
											lng : -106.3467908
										};
							
										map = new google.maps.Map(document.getElementById('map'), {
											center : myLatLng,
											zoom : 4
										});
											for (var i = 0; i < events.length; i++) {
										        //Do something
										        
										        var myLatLng = {
													lat : events[i].latitude,
													lng : events[i].longitude
												};
										        
												var marker = new google.maps.Marker({
													position: myLatLng,
													map: map,
													
													store_id: events[i].eventID
												});
										    }
									return false;
								}
							}
						})
			}
			
			function initMap() {
				
			} 
	</script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyARjj3ad8bc8Fh1K_d3khuBu_3AbOc_mW0&callback=initMap"
		async defer></script>
</body>
</html>