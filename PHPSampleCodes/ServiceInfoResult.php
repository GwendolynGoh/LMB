<html>
   <head>
        <title>Service Info Results</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
        <center><img src="bus.jpg" style="width:1400px;height:500px;></center>         
   </head>
   
   <body>
        
        <div class="container">
            <div class="row">
            <div class="col-md-12">
                <center><h1><center>FINDMYBUS</h1>
                <p>BUS SERVICE INFORMATION</p>
            </div>
            </div> 
        </div>
        
        <hr />        
        
        <?php
            $conn = mysqli_connect('localhost','root','','findmybus');
            if(!$conn){
                exit('Could not connect: '.mysqli_connect_error($conn));
            }
            
            $pQuery = "select distinct routenumber from bus_route 
                       where servicenumber = ? order by routenumber";
            
            $stmt = mysqli_prepare($conn, $pQuery);
            
            mysqli_stmt_bind_param($stmt,'s', $serviceNumber);
                
            $serviceNumber = $_POST["service"];
            
            mysqli_stmt_execute($stmt);
            mysqli_stmt_bind_result($stmt, $routeNumber_r);
            
            while(mysqli_stmt_fetch($stmt)){
                print '<h4><b>Route '.$routeNumber_r.'</b></h4>';
                print '<table border = "1">';
                print '<tr>
                        <th width = "150">Stop number</th> 
                        <th width = "300">Stop location description</th> 
                        <th width = "100">Stop order</th>
                       </tr>';
            
                
                $conn1 = mysqli_connect('localhost','root','','findmybus');
                if(!$conn1){
                    exit('Could not connect: '.mysqli_connect_error($conn));
                }
                
                $pQuery1 = "select s.stopnumber, locationdesc, stoporder
                            from bus_stop s, bus_route r
                            where s.stopnumber = r.stopnumber and servicenumber like ? and routenumber = ?
                            order by stoporder";
                
                $stmt1 = mysqli_prepare($conn1, $pQuery1);
                
                mysqli_stmt_bind_param($stmt1,'sd', $serviceNumber1, $routeNumber );
                
                $serviceNumber1 = $_POST["service"];
                $routeNumber = $routeNumber_r;
                
                mysqli_stmt_execute($stmt1);
                mysqli_stmt_bind_result($stmt1, $serviceNumber_r, $description_r, $order_r);
                
                while(mysqli_stmt_fetch($stmt1)){
                    print '<tr>';
                    print '<td width = "50" >'.$serviceNumber_r.'</td>';
                    print '<td width = "150" >'.$description_r.'</td>';
                    print '<td width = "30" >'.$order_r.'</td>';
                    print '</tr>';
                }
                
                mysqli_stmt_close($stmt1);
                mysqli_close($conn1);
            
                print '</table>
                       </br>';
            }
                
            mysqli_stmt_close($stmt);
            mysqli_close($conn);
        ?>
   </body>
</html>   