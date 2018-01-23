<html>
    <head>
        <title>FindMyBus</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <center><img src="bus.jpg" style="width:1400px;height:500px;></center> 
    </head>
    <body>
        
        <div class="container">
            <div class="row">
            <div class="col-md-12">
                <center><h1><center>FINDMYBUS</h1>
                <p>Find your bus service, driver and bus stop information below.</p>
            </div>
            </div> 
        </div>
        
        <hr />        
        
        <!--start of nonsense-->
        <!--first query-->
        <div class="row">
          <div class="col-md-4">
                
            <h4><b>SERVICE INFORMATION:</b></h4>
            
            <form method='post' action="ServiceInfoResult.php">
                Select Service: 
                <select name="service">
                    <option value="" selected></option>
                <?php
                    $conn = mysqli_connect('localhost','root','','findmybus');
                    if(!$conn){
                        exit('Could not connect: '.mysqli_connect_error($conn));
                    }
                    
                    $pQuery = "select servicenumber from service
                               order by abs(servicenumber)";
                    
                    $stmt = mysqli_prepare($conn, $pQuery);
                    
                    mysqli_stmt_execute($stmt);
                    mysqli_stmt_bind_result($stmt, $service_r);
                    
                    while(mysqli_stmt_fetch($stmt)){
                        print "<option value = $service_r>$service_r</option>";
                    }
                    
                ?>
                </select>   
                <input type="submit" value="Get Service Info" />            
            </form>                
                
          </div>        
        
        <!--second query-->
        
        <div class="row">
          <div class="col-md-4">

            <h4><b>SEARCH INFORMATION</b></h4>
            <form method = "post" action = "SearchInfoResult.php">
                Search Service | Stops:
                <input type = "text" name = "number" />
                <input type = "submit" value = "Get Service | Stop Info" />
            </form>                 
                
          </div>        
        
        <!--third query-->
        
        <div class="row">
          <div class="col-md-4">

            <h4><b>DRIVER FUNCTION</b></h4>
            <form method = "post" action = "DriverFunctionResult.php">
                Select Day
                <select name = "day">
                    <option value = "" selected> </option>
                    <option value = 1> Monday </option>
                    <option value = 2> Tuesday </option>
                    <option value = 3> Wednesday </option>
                    <option value = 4> Thursday </option>
                    <option value = 5> Friday </option>
                    <option value = 6> Saturday </option>
                    <option value = 7> Sunday </option>
                </select>
                <input type="submit" value="Get" />
            </form>                
                
          </div>
        
    </body>
</html>