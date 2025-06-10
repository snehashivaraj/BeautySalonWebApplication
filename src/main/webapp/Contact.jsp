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
            background-color: #f4f4f4;
            background-image: url(images/background.jpg);
            background-size: 100%;
            background-attachment: scroll; 
        }

        header {
            position: absolute;
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
            max-width: 400px;
            margin: 2em auto;
            background-color: #fff;
            padding: 1em;
            border-radius: 5px;
            box-sizing: border-box;
        }

        input,
        textarea,
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
            padding: 0.5em 1em;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #555;
        }
        .dropdown-menu {
            background-color: #444;
            color: #fff;
        }
        form {
            max-width: 400px;
            margin: 2em auto;
            background-color: lightgray;
            padding: 1em;
            border-radius: 30px;
            box-sizing: border-box;
            box-shadow: 0px 0px 10px 2px rgba(0,0,0,1.9);	
        }
    </style>
    <body>
    <header>
        <h1>Classy<span class="line-break"></span>Salon </h1>
        <nav>
            <a href="Services.jsp">Services</a>
           	<a href="Home.jsp"> Home </a>
        </nav>
    </header>
         <section id="contact">
         <h2>Contact Us</h2>
        <form  action="contact" method="post">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" oninput="this.value = this.value.replace(/[^a-zA-Z]/g, '')" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="message">Message:</label>
            <textarea id="message" name="message" rows="4" required></textarea>

            <button class="btn btn-success btn-lgt" type="submit">Submit</button>
        </form>
    </section>
    <script>
        // Get the value of the 'success' query parameter from the URL
        var urlParams = new URLSearchParams(window.location.search);
        var successParam = urlParams.get('success');
        
        if (successParam && successParam === '1') {
            // If success parameter is present and equals '1', show the thank you alert
            alert('Thank you, we will contact you soon.');
        }
    </script>
 </body>
 </html>