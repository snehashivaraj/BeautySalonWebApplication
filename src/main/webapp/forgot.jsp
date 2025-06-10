<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/font-awesome.min.css">
	<style>
		body {
			font-family: Arial, sans-serif;
			background-color: #f2f2f2;
			background-image: url(images/background.jpg);
			background-size: 100%;
            background-attachment: fixed;
		}
		
		 h2 {
		    color: ghostwhite;
            text-align: center; /* Center align the text */
            margin: 2em auto; /* Center the element horizontally and add some margin */
            max-width: 400px; /* Limit the width of the element */
            padding: 0.5em; /* Add padding */
            background-color: #333; /* Background color for the <h2> */
            border-radius: 2px 40px; /* Optional border-radius for rounded corners */
            display: block; /* Ensures that it takes the full width available */
            box-shadow: 1px 4px whitesmoke;
        }
		form {
			 font-family: Poppins, sans-serif;
            max-width: 400px;
            margin: 2em auto;
            padding: 1em;
            background-color: #fff;
            box-sizing: border-box;
            box-shadow: 0px 0px 10px 2px rgba(0,0,0,1.9);
            border-radius: 30px;
            font-size: 20px;
            
		}
		input[type="text"] {
			width: 100%;
			padding: 10px;
			margin-bottom: 20px;
			border: none;
			border-radius: 3px;
			box-sizing: border-box;
			font-size: 16px;
			color: #555;
			background-color: #f2f2f2;
		}
		input[type="password"] {
			width: 100%;
			padding: 10px;
			margin-bottom: 20px;
			border: none;
			border-radius: 3px;
			box-sizing: border-box;
			font-size: 16px;
			color: #555;
			background-color: #f2f2f2;
		}
		input[type="submit"] {
			background-color: #333;
			color: #fff;
			border: none;
			border-radius: 3px;
			padding: 10px 20px;
			cursor: pointer;
			font-size: 16px;
			margin-top: 20px;
		}
		input[type="submit"]:hover {
			background-color: #555;
		}
		.password-toggle {
			position: relative;
		}
		.password-toggle input[type="password"] {
			padding-right: 40px;
		}
		.password-toggle .toggle-icon {
			position: absolute;
			top: 50%;
			right: 10px;
			transform: translateY(-50%);
			cursor: pointer;
			z-index: 1;
		}
		.password-toggle .toggle-icon i {
			color: #555;
			font-size: 16px;
		}
		.password-toggle .toggle-icon i:hover {
			color: #333;
		}
		.password-toggle .toggle-icon.active i {
			color: #333;
		}
		.forgot-password {
			text-align: right;
			margin-top: 10px;
		}
		.forgot-password a {
			color: #333;
			text-decoration: none;
		}
		
	</style>
</head>
<body>
 <nav>
            <a href="Login.jsp"> Back </a>
        </nav>
<div class="container mt-5">

    <h2 class="mb-6">Forgot password </h2>
    </div>
    
<script>
		function togglePassword() {
			var passwordInput = document.getElementById("password");
			var toggleIcon = document.getElementById("toggle-icon");
			if (passwordInput.type === "password") {
				passwordInput.type = "text";
				toggleIcon.classList.add("active");
			} else {
				passwordInput.type = "password";
				toggleIcon.classList.remove("active");
			}
		}
	</script>
	<form action="Forgot" method="post">
		<label for="text">Enter your mail id </label>
		<input type="text" id="email" name="email" required><br>
		<label for="password">Password:</label>
		<div class="password-toggle">
			<input type="password" id="password" name="password" required>
			<div class="toggle-icon" id="toggle-icon" onclick="togglePassword()">
				<i class="fa fa-eye"></i>
				</div>
			</div>
		<input type="submit" value="Reset Password">
	</form>
</body>
</html>
