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
<body>
	<div class="container-fluid p-0 d-flex flex-column h-100">
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	       	<a class="navbar-brand font-weight-bold" href="index.jsp">Play</a>
	       	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	   			<span class="navbar-toggler-icon"></span>
	 		</button>
	 			
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<div class="mr-auto">
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
	     				<a class="nav-link" href="login.jsp">Login</a>
	   				</li>
	   				<li class="nav-item">
	     				<a class="nav-link" href="register.jsp">Register</a>
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
		
		function CenterControl(controlDiv, map) {

			// Set CSS for the control border.
			var controlUI = document.createElement('div');
			controlUI.style.backgroundColor = '#fff';
			controlUI.style.border = '2px solid #fff';
			controlUI.style.borderRadius = '3px';
			controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
			controlUI.style.cursor = 'pointer';
			controlUI.style.margin = '10px';
			controlUI.style.textAlign = 'center';
			controlUI.title = 'Click to add an event';
			controlDiv.appendChild(controlUI);

			// Set CSS for the control interior.
			var controlText = document.createElement('div');
			controlText.style.color = 'rgb(25,25,25)';
			controlText.style.fontFamily = 'Roboto,Arial,sans-serif';
			controlText.style.fontSize = '16px';
			controlText.style.lineHeight = '38px';
			controlText.style.paddingLeft = '5px';
			controlText.style.paddingRight = '5px';
			controlText.innerHTML = 'Add Event';
			controlUI.appendChild(controlText);

			// Setup the click event listeners: simply set the map to Chicago.
			controlUI.addEventListener('click', function() {
				console.log("here");
			});

		}

		function initMap() {
			var myLatLng = {
				lat : 38.6446543,
				lng : -106.3467908
			};

			map = new google.maps.Map(document.getElementById('map'), {
				center : myLatLng,
				zoom : 6,
				streetViewControl : false,
				mapTypeControl : false,
				scaleControlOptions : google.maps.ControlPosition.TOP_LEFT,
				styles : [ {
					"elementType" : "geometry",
					"stylers" : [ {
						"color" : "#242f3e"
					} ]
				}, {
					"elementType" : "labels.text.fill",
					"stylers" : [ {
						"color" : "#746855"
					} ]
				}, {
					"elementType" : "labels.text.stroke",
					"stylers" : [ {
						"color" : "#242f3e"
					} ]
				}, {
					"featureType" : "administrative",
					"elementType" : "geometry",
					"stylers" : [ {
						"visibility" : "off"
					} ]
				}, {
					"featureType" : "administrative.locality",
					"elementType" : "labels.text.fill",
					"stylers" : [ {
						"color" : "#d59563"
					} ]
				}, {
					"featureType" : "administrative.neighborhood",
					"stylers" : [ {
						"visibility" : "off"
					} ]
				}, {
					"featureType" : "poi",
					"stylers" : [ {
						"visibility" : "off"
					} ]
				}, {
					"featureType" : "poi",
					"elementType" : "labels.text",
					"stylers" : [ {
						"visibility" : "off"
					} ]
				}, {
					"featureType" : "poi",
					"elementType" : "labels.text.fill",
					"stylers" : [ {
						"color" : "#d59563"
					} ]
				}, {
					"featureType" : "poi.park",
					"elementType" : "geometry",
					"stylers" : [ {
						"color" : "#263c3f"
					} ]
				}, {
					"featureType" : "poi.park",
					"elementType" : "labels.text.fill",
					"stylers" : [ {
						"color" : "#6b9a76"
					} ]
				}, {
					"featureType" : "road",
					"elementType" : "geometry",
					"stylers" : [ {
						"color" : "#38414e"
					} ]
				}, {
					"featureType" : "road",
					"elementType" : "geometry.stroke",
					"stylers" : [ {
						"color" : "#212a37"
					} ]
				}, {
					"featureType" : "road",
					"elementType" : "labels",
					"stylers" : [ {
						"visibility" : "off"
					} ]
				}, {
					"featureType" : "road",
					"elementType" : "labels.icon",
					"stylers" : [ {
						"visibility" : "off"
					} ]
				}, {
					"featureType" : "road",
					"elementType" : "labels.text.fill",
					"stylers" : [ {
						"color" : "#9ca5b3"
					} ]
				}, {
					"featureType" : "road.arterial",
					"elementType" : "labels",
					"stylers" : [ {
						"visibility" : "off"
					} ]
				}, {
					"featureType" : "road.highway",
					"elementType" : "geometry",
					"stylers" : [ {
						"color" : "#746855"
					} ]
				}, {
					"featureType" : "road.highway",
					"elementType" : "geometry.stroke",
					"stylers" : [ {
						"color" : "#1f2835"
					} ]
				}, {
					"featureType" : "road.highway",
					"elementType" : "labels",
					"stylers" : [ {
						"visibility" : "off"
					} ]
				}, {
					"featureType" : "road.highway",
					"elementType" : "labels.text.fill",
					"stylers" : [ {
						"color" : "#f3d19c"
					} ]
				}, {
					"featureType" : "road.local",
					"stylers" : [ {
						"visibility" : "off"
					} ]
				}, {
					"featureType" : "transit",
					"stylers" : [ {
						"visibility" : "off"
					} ]
				}, {
					"featureType" : "transit",
					"elementType" : "geometry",
					"stylers" : [ {
						"color" : "#2f3948"
					} ]
				}, {
					"featureType" : "transit.station",
					"elementType" : "labels.text.fill",
					"stylers" : [ {
						"color" : "#d59563"
					} ]
				}, {
					"featureType" : "water",
					"elementType" : "geometry",
					"stylers" : [ {
						"color" : "#17263c"
					} ]
				}, {
					"featureType" : "water",
					"elementType" : "labels.text",
					"stylers" : [ {
						"visibility" : "off"
					} ]
				}, {
					"featureType" : "water",
					"elementType" : "labels.text.fill",
					"stylers" : [ {
						"color" : "#515c6d"
					} ]
				}, {
					"featureType" : "water",
					"elementType" : "labels.text.stroke",
					"stylers" : [ {
						"color" : "#17263c"
					} ]
				} ]
			});
			
			
			var centerControlDiv = document.createElement('div');
			var centerControl = new CenterControl(centerControlDiv, map);

			centerControlDiv.index = 1;
			map.controls[google.maps.ControlPosition.TOP_LEFT].push(centerControlDiv);
		}
	</script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyARjj3ad8bc8Fh1K_d3khuBu_3AbOc_mW0&callback=initMap"
		async defer></script>
</body>
</html>