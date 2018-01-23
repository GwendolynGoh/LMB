<html>
    <head><title>Driver Function Query</title></head>
        <body>
            <h1>Driver Function Query</h1>
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
        </body>
</html>