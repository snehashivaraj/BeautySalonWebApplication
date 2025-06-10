<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Beauty Salon</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        header {
            position: absolute;
            top: 0;
            left: 0;
            bottom:35em;
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

        .carousel-container {
            position: relative;
            z-index: 1; /* Ensure the carousel is behind the header and navigation */
        }

        .carousel-inner {
            position: relative;
        }

        .carousel-item {
            position: relative;
        }

        .carousel-item video {
            width: %;
            height: auto;
        }
        .carousel-caption {
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 3; /* Set a z-index higher than the carousel items */
        text-align: center;
        color: #fff; /* Adjust text color as needed */
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

        h2 {
            color: #333;
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
        /* Modal CSS */
.modal {
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 9999; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: 15% auto; /* 15% from the top and centered */
  padding: 20px;
  border: 1px solid #888;
  width: 80%; /* Could be more or less, depending on screen size */
}

/* Close Button */
.close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.close:hover,
.close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}
        
    </style>
</head>
<body>
    <header>
        <h1> Classy <span class="line-break"></span>  Salon </h1>
        <nav>
            <a href="Services.jsp">Services</a>
            <a href="Contact.jsp">Contact</a>
            <a href="Registration.jsp">Login/Signup</a>
            <a href="#aboutus" id="aboutUsLink"> About us </a>
            <a href="Appointment.jsp"> Appointment </a>
            <a href="Alogin.jsp"> Staff </a>
        </nav>
    </header>

    <div class="carousel-container-fluid">
        <div id="carouselExampleControls" class="carousel slide vertical" data-ride="carousel">
            <div class="carousel-inner">
                <!-- First slide -->
                <div class="carousel-item active">
                    <video autoplay muted loop width="100%" height="auto">
                        <source src="images/bs1.mp4" type="video/mp4">
					</video>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal HTML -->
<div id="myModal" class="modal">
  <div class="modal-content">
    <span class="close">&times;</span>
    <p id="modal-text"></p>
  </div>
</div>
    

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
     <script>
        // Add an event listener to the "Appointment" navigation link
        document.querySelector('a[href="Appointment.jsp"]').addEventListener('click', function(event) {
            // Display a popup box
            alert('You have to login to your account to .');
            // Prevent the default action of following the link
            event.preventDefault();
        });
    </script>
    <script>
 // Add an event listener to the "About us" navigation link
    document.getElementById('aboutUsLink').addEventListener('click', function(event) {
        event.preventDefault(); // Prevent the default behavior of following the link
        document.getElementById('modal-text').innerText = 'V.S Salon, dedicated to enhancing your natural beauty and boosting your confidence. With years of experience in the beauty industry, our talented team of stylists and professionals are committed to providing top-notch services tailored to your needs. Step into our welcoming space, where relaxation and transformation await. Let us pamper you with our expertise and personalized care. Discover the ultimate salon experience with us today!'; // Set the text content of the modal
        document.getElementById('myModal').style.display = 'block'; // Display the modal
    });

    // Get the close button element
    var closeButton = document.getElementsByClassName("close")[0];

    // When the user clicks on the close button, close the modal
    closeButton.onclick = function() {
      document.getElementById('myModal').style.display = 'none';
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
      if (event.target == document.getElementById('myModal')) {
        document.getElementById('myModal').style.display = 'none';
      }
    }

    </script>

</body>
</html>