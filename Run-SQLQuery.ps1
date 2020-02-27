$serverName         = ".\"
$databaseName       = "AxDB"
$ConnectionString   = "server=$serverName;database=$databaseName;Integrated Security=True;"
#'Data Source=.\;Initial Catalog=AxDB;Integrated Security=True;ApplicationIntent=ReadOnly'
function Execute-SQLQuery([string]$query) {
    
    $SQLConnection = New-Object System.Data.SqlClient.sqlConnection 
    $SQLConnection.ConnectionString =  $ConnectionString

    #SQL Command - set up the SQL call
    $SQLCommand = New-Object System.Data.SqlClient.SqlCommand;
    $SQLCommand.Connection = $SQLConnection;
    $SQLCommand.CommandText = $storedProcedureCall;
    
    #SQL Adapter - get the result using the SQL command
    $SQLAdapter = New-Object System.data.SqlClient.SqlDataAdapter($query, $SQLConnection)
 #   $SQLAdapter.SelectCommand = $SQLCommand
    $SQLDataSet = New-Object System.Data.DataSet
    $SQLAdapter.Fill($SQLDataSet)

    $SQLConnection.Close()

    return $SQLDataSet.Tables[0]
}

$SQLResult = Execute-SQLQuery "SELECT * FROM CUSTTABLE WHERE DATAAREAID='TVP'"

$SQLResult | Format-Table