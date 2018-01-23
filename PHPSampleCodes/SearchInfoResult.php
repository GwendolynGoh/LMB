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
                <p>BUS SERVICE / BUS STOP INFORMATION</p>
            </div>
            </div> 
        </div>
        
        <hr /> 
    
        <h4><b>Bus Services</b></h4>
        
        <table border = "1">
        <tr>
            <th width = "140">Service number</th> 
            <th width = "100">Frequency</th> 
            <th width = "200">First bus Start Time</th> 
            <th width = "150">Route Number</th> 
            <th width = "200">Start Stop Desciption</th> 
            <th width = "200">End Stop Description</th>
        </tr>
        <?php
        
            $conn = mysqli_connect('localhost','root','','findmybus');
            if(!$conn){
                exit('Could not connect: '.mysqli_connect_error($conn));
            }
            
            $pQuery =  "select s.serviceNumber, frequency, startTime,
                        r.routeNumber,bs1.locationDesc as 'Start Stop Description',
                        bs2.locationDesc as 'End Stop Description'
                        from Service s,Route r,Bus_Stop bs1,Bus_stop bs2
                        where s.serviceNumber = r.serviceNumber and startBusStop = bs1.stopNumber
                        and endBusStop = bs2.stopNumber and s.serviceNumber like ?
                        order by abs(s.serviceNumber)";
            
            $stmt = mysqli_prepare($conn, $pQuery);
            
            mysqli_stmt_bind_param($stmt,'s', $numberLike );
            
            $number = $_POST["number"];
            $numberLike = '%'.$number.'%';
            
            mysqli_stmt_execute($stmt);
            mysqli_stmt_bind_result($stmt, $serviceNumber_r, $frequency_r, $firstBusStartTime_r, $routeNumber_r, $startStopDesc_r, $endStopDesc_r);
            
            while(mysqli_stmt_fetch($stmt)){
                print '<tr>';
                print '<td>'.$serviceNumber_r.'</td>';
                print '<td>'.$frequency_r.'</td>';
                print '<td>'.$firstBusStartTime_r.'</td>';
                print '<td>'.$routeNumber_r.'</td>';
                print '<td>'.$startStopDesc_r.'</td>';
                print '<td>'.$endStopDesc_r.'</td>';
                print '</tr>';
            }          
            
            mysqli_stmt_close($stmt);
            mysqli_close($conn);
        ?>
        </table>
        </br>
        <h4><b>Bus Stops</b></h4>
        <table border = "1">
        <tr>
            <th width = "130">Stop number</th>
            <th width = "150">Stop address</th>
            <th width = "200">Service numbers served</th> 
        </tr>
        
        <?php
            $conn = mysqli_connect('localhost','root','','findmybus');
            if(!$conn){
                exit('Could not connect: '.mysqli_connect_error($conn));
            }
            
            $pQuery =  "select bs.stopnumber, bs.address, count(distinct br.servicenumber)
                        from bus_route br inner join bus_stop bs
                        on br.stopnumber = bs.stopnumber
                        where bs.stopnumber like ?
                        group by stopnumber, address
                        order by stopnumber";
            
            $stmt = mysqli_prepare($conn, $pQuery);
            
            mysqli_stmt_bind_param($stmt,'s', $numberLike );
            
            $number = $_POST["number"];
            $numberLike = '%'.$number.'%';
            
            mysqli_stmt_execute($stmt);
            mysqli_stmt_bind_result($stmt, $stopNumber_r, $stopAddress_r, $serviceNumbersServed_r);
            
            while(mysqli_stmt_fetch($stmt)){
                print '<tr>';
                print '<td>'.$stopNumber_r.'</td>';
                print '<td>'.$stopAddress_r.'</td>';
                print '<td>'.$serviceNumbersServed_r.'</td>';
                print '</tr>';
            }
            
            mysqli_stmt_close($stmt);
            mysqli_close($conn);
        
        ?>
        </table>
   </body>
</html>   