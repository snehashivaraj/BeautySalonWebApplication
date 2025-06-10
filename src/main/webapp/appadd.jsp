<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> Update </title>
    <style>
        form {
            font-family: 'Poppins', sans-serif;
            max-width: 400px;
            margin: 2em auto;
            background-color: #fff;
            padding: 1em;
            border-radius: 30px;
            box-sizing: border-box;
            box-shadow: 0px 0px 10px 2px rgba(0,0,0,1.9);
        }
        h2 {
            color: ghostwhite;
            text-align: center;
            margin: 2em auto;
            max-width: 400px;
            padding: 0.5em;
            background-color: #333;
            border-radius: 2px 40px;
            display: block;
            box-shadow: 1px 4px whitesmoke;
        }
        body{
    		background-image: url('images/adminback.jpg');
    		background-size:100%;
    		background-attachment: scrool;
        }
    	label {
            font-weight: bold;
        }
        table {
        	background-color: ghostwhite;
        	}
    section {
            padding: 2em;
            background-color: rgb(0,1,0,0.3);
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
    	h3{
    		text-align: center; /* Center align the text */
    		margin: 2em auto; /* Center the element horizontally and add some margin */
    		max-width: 400px; /* Limit the width of the element */
    		padding: 0.5em; /* Add padding */
    		font-size:30px;
    		cursor: pointer;
    		}
        .radio-container {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<nav>
	<a href="aapdetails.jsp"> Appointment details </a>
	<a href="dashboard.jsp"> Dashboard </a>
	<a href="Home.jsp"> Logout </a>
</nav>
    <h2>UPDATE :</h2>

    <div class="radio-container">
        <input type="radio" name="serviceType" value="add" id="addRadio" checked>
        <label for="addRadio">Add Services</label>

        <input type="radio" name="serviceType" value="remove" id="removeRadio">
        <label for="removeRadio">Remove Services</label>

        <input type="radio" name="serviceType" value="update" id="updateRadio">
        <label for="updateRadio">Update Price</label>
    </div>

    <div id="addServicesForm">
        <h3>ADD SERVICES</h3>
        <form action="Appadd" method="post">
            <input type="hidden" name="action" value="add">
            Category Name: <input type="text" name="categoryName"><br>
            Service Name: <input type="text" name="serviceName"><br>
            Price: <input type="text" name="price"><br>
            <input type="submit" value="Add">
        </form>
    </div>

    <div id="removeServicesForm" style="display: none;">
        <h3>REMOVE SERVICE</h3>
        <form action="Appadd" method="post">
            <input type="hidden" name="action" value="remove">
            Category Name: <input type="text" name="categoryName"><br>
            Service Name: <input type="text" name="serviceName"><br>
            <input type="submit" value="Remove">
        </form>
    </div>

    <div id="updatePriceForm" style="display: none;">
        <h3>UPDATE PRICE</h3>
        <form action="Appadd" method="post">
            <input type="hidden" name="action" value="update">
            Service Name: <input type="text" name="serviceName"><br>
            New Price: <input type="text" name="newPrice"><br>
            <input type="submit" value="Update">
        </form>
    </div>

    <script>
        // Get the radio buttons and forms
        const addRadio = document.getElementById('addRadio');
        const removeRadio = document.getElementById('removeRadio');
        const updateRadio = document.getElementById('updateRadio');
        const addServicesForm = document.getElementById('addServicesForm');
        const removeServicesForm = document.getElementById('removeServicesForm');
        const updatePriceForm = document.getElementById('updatePriceForm');

        // Function to show/hide forms based on selected radio button
        function toggleForms() {
            addServicesForm.style.display = 'none';
            removeServicesForm.style.display = 'none';
            updatePriceForm.style.display = 'none';

            if (addRadio.checked) {
                addServicesForm.style.display = 'block';
            } else if (removeRadio.checked) {
                removeServicesForm.style.display = 'block';
            } else if (updateRadio.checked) {
                updatePriceForm.style.display = 'block';
            }
        }

        // Add event listeners to radio buttons
        addRadio.addEventListener('change', toggleForms);
        removeRadio.addEventListener('change', toggleForms);
        updateRadio.addEventListener('change', toggleForms);

        // Initially show the appropriate form based on the default checked radio button
        toggleForms();
    </script>
</body>
</html>
