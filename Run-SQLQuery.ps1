$serverName         = ".\"
$databaseName       = "AxDB"
$ConnectionString   = "server=$serverName;database=$databaseName;Integrated Security=True;"

function Initialize-SQLQuery([string]$query) {
    
    $SQLConnection = New-Object System.Data.SqlClient.sqlConnection 
    $SQLConnection.ConnectionString =  $ConnectionString

    #SQL Command - set up the SQL call
    $SQLCommand = New-Object System.Data.SqlClient.SqlCommand;
    $SQLCommand.Connection = $SQLConnection;
    $SQLCommand.CommandText = $storedProcedureCall;
    
    #SQL Adapter - get the result using the SQL command
    $SQLAdapter = New-Object System.data.SqlClient.SqlDataAdapter($query, $SQLConnection)
    $SQLDataSet = New-Object System.Data.DataSet
    $SQLAdapter.Fill($SQLDataSet)

    $SQLConnection.Close()

    return $SQLDataSet.Tables[0]
}

$SQLResult = Initialize-SQLQuery "SELECT ACCOUNTNUM, INVOICEACCOUNT, PARTY, DATAAREAID FROM CUSTTABLE WHERE DATAAREAID='SYP'"

$SQLResult | Format-Table