<html>
   <head>
        <title>Driver Function Results</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <center><img src="bus.jpg" style="width:1400px;height:500px;></center>        
    </head>
    
    <body>
    
        <div class="container">
            <div class="row">
            <div class="col-md-12">
                <center><h1><center>FINDMYBUS</h1>
                <p>BUS DRIVER INFORMATION</p>
            </div>
            </div> 
        </div>
        
        <hr />
        
        <h4><b>Bus Driver Information</b></h4>
    
        <table border = "1">
        <tr>
            <th width = "100">Staff ID</th>
            <th width = "100">NRIC</th>
            <th width = "100">Driver Name</th>
            <th width = "140">License Number</th>
        </tr>
        <?php
            
            $conn = mysqli_connect('localhost','root','','findmybus');
            if(!$conn){
                exit('Could not connect: '.mysqli_connect_error($conn));
            }
            
            $pQuery = "select distinct d.staffId,NRIC,DriverName,LicenseNumber from 
                       Driver d,driver_offdays do1 
                       where d.staffid = do1.StaffID and OffDay <> ? order by DriverName,staffID;";
            
            $stmt = mysqli_prepare($conn, $pQuery);
            
            mysqli_stmt_bind_param($stmt,'i', $offday );
            
            $offday = $_POST["day"];
            
            mysqli_stmt_execute($stmt);
            mysqli_stmt_bind_result($stmt, $staffID_r, $NRIC_r, $driverName_r, $licenseNumber_r);
            
            while(mysqli_stmt_fetch($stmt)){
                print '<tr>';
                print '<td>'.$staffID_r.'</td>';
                print '<td>'.$NRIC_r.'</td>';
                print '<td>'.$driverName_r.'</td>';
                print '<td>'.$licenseNumber_r.'</td>';
                print '</tr>';
            }
            
            mysqli_stmt_close($stmt);
            mysqli_close($conn);
        ?>
        </table>
   </body>
</html>   