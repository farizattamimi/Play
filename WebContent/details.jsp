<%@page import="classes.Comment"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@page import="classes.Event" %>
<%@page import="classes.EventDateParser" %>
<%@page import="java.util.Date" %>
<%
	String username = "";
	String userID = "";
	boolean loggedIn = false;
	if (session.getAttribute("username") != null && !session.getAttribute("username").equals("")) {
		username = (String)session.getAttribute("username");
		userID = (String)session.getAttribute("userID");
		loggedIn = true;
	}
	
	Event e = (Event)request.getAttribute("event");
	String eventIDString = "";
	Date eventDate = null;
	EventDateParser date = null;
	String commentString = "";
	ArrayList<Comment> c = null;
	String name = "";
	String category = "";
	if(e == null) {
		RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
	   	rd.forward(request, response);
	} else {
		eventIDString = String.valueOf(e.getEventID());

		eventDate = e.getExpirationDate();
		date = new EventDateParser(eventDate);
		
		c = e.getComments();
		for (int i = 0; i < c.size(); i ++) {
			commentString += c.get(i).getCreator().getUsername() + ": " + c.get(i).getMessage() + "<br>";
		}
		
		name = e.getName();
		category = e.getCategory();
	}
	
	
	
%>


<html>
<head>
	<meta charset="UTF-8">
	<title><%= name %> details</title>
	
	<link rel="stylesheet" href="bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="fontawesome/css/all.min.css">
	<link rel="stylesheet" href="css/details.css">
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	<link rel="manifest" href="site.webmanifest">
	
	<script src="jquery/jquery-3.3.1.min.js"></script>
	<script>
		var socket;
		var upvoteSocket;
		function connectToServer() {
			socket = new WebSocket("ws://localhost:8080/Play/commentSocket");
			socket.onopen = function(event) {
				//document.getElementById("comments").innerHTML += "Connected!<br />";
			}
			socket.onmessage = function(event) {
				document.getElementById("comments").innerHTML += event.data + "<br />";
			}
			socket.onclose = function(event) {
				//document.getElementById("comments").innerHTML += "Disconnected!<br />";
			}
			
			//upvote Socket
			upvoteSocket = new WebSocket("ws://localhost:8080/Play/upvoteSocket");
			upvoteSocket.onopen = function(event) {
				//document.getElementById("upvotes").innerHTML = "Connected!";
			}
			upvoteSocket.onmessage = function(event) {
				document.getElementById("upvotes").innerHTML = event.data;
			}
			upvoteSocket.onclose = function(event) {
				//document.getElementById("upvotes").innerHTML = "Disconnected!";
			}
		}
		
		function sendMessage() {
			var comment = new Object();
			comment.creatorID = "<%= userID%>";
			comment.eventID  = "<%= eventIDString%>";
			comment.message = document.getElementById("commentInput").value;
			var jsonString= JSON.stringify(comment);
			socket.send(jsonString);
			document.getElementById("commentInput").value = "";
			return false;
		}
		
		function sendUpvote() {
			var upvote = new Object();
			upvote.eventID  = "<%= eventIDString%>";
			upvote.message = "upvote";
			var jsonString= JSON.stringify(upvote);
			upvoteSocket.send(jsonString);
			document.getElementById("upvoteButton").disabled = true;
			document.getElementById("downvoteButton").disabled = true;
			return false;
		}
		
		function sendDownvote() {
			var downvote = new Object();
			downvote.eventID  = "<%= eventIDString%>";
			downvote.message = "downvote";
			var jsonString= JSON.stringify(downvote);
			upvoteSocket.send(jsonString);
			document.getElementById("upvoteButton").disabled = true;
			document.getElementById("downvoteButton").disabled = true;
			return false;
		}
		
		
		$(document).ready(function(){
		    $('#commentInput').keypress(function(e){
		      if(e.keyCode==13)
		      $('#commentButton').click();
		    });
		});
	
	
	</script>
</head>
<body onload="connectToServer()">
	<div class="container-fluid p-0">
		<nav class="navbar navbar-expand-lg navbar-dark">
	       	<a class="navbar-brand font-weight-bold" href="index.jsp">Play</a>
	       	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
	   			<span class="navbar-toggler-icon"></span>
	 		</button>
	 			
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav ml-auto">
				<% if(loggedIn) { %>
	   				<li class="nav-item d-flex" style="color: rgba(255,255,255,.5)">
	     				Hi,&nbsp;<a class="nav-link p-0" href="profile.jsp"> <%= username %></a>&nbsp;(<a class="nav-link p-0" href="LogoutServlet">logout</a>)
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
	   	
	   	<!-- <div class="card w-75 mx-auto">
		  <img src="event-backgrounds/dinner.jpg" class="card-img-top" alt="...">
		  <div class="card-body">
		    <h5 class="card-title">Card title</h5>
		    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
		    <a href="#" class="btn btn-primary">Go somewhere</a>
		  </div>
		</div> -->
	   	<br/>
	   	<br/>
		<div class="w-75 my-5 mx-auto bg-white rounded">
			<div class="row mx-0">
				<div id="img-placeholder" class="col-8 p-0">
						<img src="categoryPhotos/<%=category%>.jpg" class="img-fluid">
				</div>
				<div class="col-4 d-flex flex-column justify-content-between">
					<p class="h4 mt-2">
						<% if(date != null) { %><%= date.getDay() %> <% } %> <br/>
						<% if(date != null) { %><%= date.getMonth() %><% } %>
					</p>
					<div>
						<h3 class="mb-2"><% if(e != null) { %><%= e.getName() %><% } %></h3>
						<p class="h5 text-muted">By <% if(e != null) { %><%= e.getCreator().getUsername() %><% } %></p>
					</div>
					<p class="mb-1">Begins at <% if(date != null) { %><%= date.getHour() + ":" + String.format("%02d", date.getMinute()) %><% } %> <br> <% if(e != null) { %><%= e.getAddress() %><% } %></p>
				</div>
			</div>
			<div class="row mx-0">
				<div class="col-1 mx-auto nav flex-column">
					</br>
					<p class="text-center"><strong>Upvotes</strong></p>
					<%if (loggedIn) { %>
						<button id="upvoteButton" class="btn btn-dark mx-auto" data-toggle="modal" data-target="" onclick="sendUpvote();">↑</button>
					<%} %>
					<p class="font-weight-bold text-center pt-2" id="upvotes" class="text-muted"><% if(e != null) { %><%= e.getUpvotes() %><% } %></p> 
					<%if (loggedIn) { %>
					<button id="downvoteButton" class="btn btn-dark mx-auto" data-toggle="modal" data-target="" onclick="sendDownvote();">↓</button>
					<%} %>
				</div>
				<div class="col-10 mx-auto mt-4 pb-4 pl-0">
					<p><strong>Description</strong></p>
					<p class="text-muted"><% if(e != null) { %><%= e.getDescription() %><% } %></p>
					<a target="_blank" rel="noopener noreferrer" href="http://<% if(e != null) { %><%= e.getWebsite() %><% } %>" class="mb-5"><strong>More info at...</strong></a>
				</div>
			</div>
			<div class="w-75 mx-auto mt-4 pb-4 pl-4">
				<p><strong>Comments</strong></p>
				<p id="comments" class="text-muted"><%= commentString %></p>
				<%if (loggedIn) { %>
				<div class="input-group mb-3">
					<input type="text" class="form-control" id="commentInput" placeholder="Write Comment">
					<div class="input-group-append">
						<button id="commentButton" class="btn btn-dark" data-toggle="modal" data-target="" onclick="sendMessage();">Comment</button>
					</div>
				</div>
				<%} %>
			</div>
			
			
			<!-- TODO upvote section  -->
		</div>	   	
	</div>

	<script src="jquery/jquery-3.3.1.min.js"></script>
	<script src="bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>