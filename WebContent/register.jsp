<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Register</title>
	
	<link rel="stylesheet" href="bootstrap/bootstrap.min.css">
	<link rel="stylesheet" href="fontawesome/all.min.css">
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
	<link rel="manifest" href="site.webmanifest">

	<%
		boolean loggedIn = false;
		// check if logged in
	%>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script>
		function register() {
			uname = document.getElementById('usernameInput').value;
			pw1 = document.getElementById('passwordInput1').value;
			pw2 = document.getElementById('passwordInput2').value;
			$
					.ajax({
						url : "RegisterServlet",
						data : {
							username : uname,
							password1 : pw1,
							password2 : pw2
						},
						success : function(result) {
							console.log(result);
							if (result === "") {
								window.location.href = "index.jsp";
							} else {
								document.getElementById('errorMessage').innerHTML = result;
								return false;
							}
						}
					})
		}
	</script>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
       	<a class="navbar-brand font-weight-bold" href="index.jsp">Play</a>
       	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
   			<span class="navbar-toggler-icon"></span>
 		</button>
 			
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
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

	<div class="container-fluid">
		<form method="POST" onsubmit="return false;">
			<div class="form-group">
				<br />
				<label for="usernameInput">Username</label> <input
					type="text" class="form-control" id="usernameInput"
					aria-describedby="emailHelp" placeholder="Enter username">
			</div>
			<div class="form-group">
				<label for="InputPassword1">Password</label> <input
					type="password" class="form-control" id="passwordInput1"
					placeholder="Password">
			</div>
			<div class="form-group">
				<label for="InputPassword2">Confirm Password</label> <input
					type="password" class="form-control" id="passwordInput2"
					placeholder="Confirm Password">
			</div>
			<small id="errorMessage" class="form-text text-muted">&nbsp;</small>
			<button type="submit" class="btn btn-primary" onclick="return register();">Register</button>
		</form>

	</div>

	<script src="jquery/jquery-3.3.1.min.js" ></script>
	<script src="bootstrap/bootstrap.bundle.min.js" ></script>
</body>
</html>