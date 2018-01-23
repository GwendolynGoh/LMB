<html>
    <head>
        <title>FindMyBus</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <center><img src="bus.jpg" style="width:1000px;height:500px;></center> 
    </head>
    <body>
        
        <div class="container">
            <div class="row">
            <div class="col-md-12">
                <center><h1><center>FINDMYBUS</h1>
                <p>Click to navigate around</p>
            </div>
            </div> 
        </div>
        
        <hr />        
        
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
                    print "<option value = $service_r>$service_r</option>"; ;
                }
                
            ?>
            </select>   
            <input type="submit" value="Get Service Info" />            
        </form>
    </body>
</html>