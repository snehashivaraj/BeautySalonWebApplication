<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Beauty Salon</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <style>
        body {  
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #8a70f9;
            background-image: url(images/background.jpg);
            background-size: 100%;
            background-attachment: fixed;
        }

        header {
            bposition: absolute;
            top: 0;
            left: 0;
            width: 100%;
            color: darkmagenta;
            text-align: center;
            padding: 0.5em;
            z-index: 2; /* Ensure the header is above the carousel */
            display: flex;
            justify-content: space-between; /* Align items horizontally */
            align-items: center; /* Align items vertically */
        }

        nav {
            padding: 1em;
            text-align: right; /* Align navigation items to the right */
        }

        nav a {
            color: #fff;
            text-decoration: none;
            padding: 0.2em 0.5em;
            margin: 0.1em;
            border-radius: 10px 1px;
            background-color: #444; /* Background color only till text */
            display: inline-block; /* Display as inline-block to apply background only to the text */
        }

        nav a:hover {
            background-color: aliceblue;
        }

        .dropdown-menu-up {
            top: auto;
            bottom: 100%;
        }

        section {
            padding: 2em;
        }
        h1 {
            font-size:4em; /* Font size */
            font-family: "Times New Roman", Times, serif; /* Change font family */
            font-style: italic; /* Change font style */
        	text-shadow: 2px 1px pink;
           		
        }
        .line-break {
            display: block; /* Display as block to force line break */
            margin-right: 5em; 
        }

        .dropdown-menu-up {
            top: auto;
            bottom: 100%;
        }

        section {
            padding: 2em;
        }

        h2 {
            color: ghostwhite;
    		text-align: center; /* Center align the text */
    		margin: 2em auto; /* Center the element horizontally and add some margin */
    		max-width: 400px; /* Limit the width of the element */
    		padding: 0.5em; /* Add padding */
    		background-color: #333; /* Background color for the <h2> */
    		border-radius: 2px 40px; /* Optional border-radius for rounded corners */
    		display: block; /* Set to inline-block to only cover the width of the text */
    		box-shadow: 1px 4px whitesmoke;
    	}

        .services {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            }

        .service {
            border: 1px solid #ddd;
            border-radius: 5px;
            padding: 1em;
            margin: 1em;
            width: 30%;
            box-sizing: border-box;
            background-color: #fff;
        }
        form { 
            font-family: Poppins, sans-serif;
            max-width: 400px;
            max-height: 1000px;
            margin: 2em auto;
            padding: 1em;
            background-color: #fff;
            box-sizing: border-box;
            box-shadow: 0px 0px 10px 2px rgba(0,0,0,0.9);
            border-radius: 30px 30px 30px 30px;
            font-size: 20px;
            
        }

        input,
        button {
            display: block;
            width: 100%;
            margin-bottom: 1em;
            padding: 0.5em;
            box-sizing: border-box;
        }

        button {
            background-color: #333;
            color: #fff;
            border: none;
            padding: 12px 20px;
            border-radius: 5px;
            cursor: pointer;
            border:2px solid transparent;
            transition: 0.3s ease;
        }

        button:hover {
            background-color: #555;
        }
        .dropdown-menu {
            background-color: #444;
            color: #fff;
        }
        .button-container {
            /* Center the container horizontally */
            text-align: center;
        }
    </style>
    <script>
    // Function to validate password and confirm password
    function validatePassword() {
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("conform").value;

        // Check if the passwords match
        if (password !== confirmPassword) {
            alert("Passwords do not match. Please enter matching passwords.");
            return false;
        }

        return true;
    }
</script>
</head>
<body>
<header> 
        <h1>Classy<span class="line-break"></span>Salon </h1>
                <nav>
            <a href="contact.jsp">Help</a>
            <a href="Home.jsp"> Home </a>
        </nav>
    </header>
    

<div class="container mt-5">
    <h2 class="mb-6"> LOGIN </h2>

    <form action="Login" method="post" onsubmit="return validatePassword()">
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <div class="forget">
            <a href="forgot.jsp">Forget password?</a>
        </div>
        
        <div class="button-container">
            <button type="submit" class="btn btn-primary">Login</button>
        </div>
        <div>
            
        </div>
        <div class="Create-account">
            <p> Don't have an account? <a href="Registration.jsp"> Create account</a></p>
        </div>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>
</html>