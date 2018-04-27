<html lang="en">
<head>
  <title>Lets Build Stuff!</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
      <h2>Lets Build Stuff!! - Admin Portal <a href="form.html" class="btn btn-default"> Another Registrations</a> </h2>
      <p><i>An Exicting Event Hosted by Students of CS251.</i></p>
    <br>
    <h4 > Database Status:
    <?php
        // open the database, a file named mysqlitedb.db should exist
        class MyDB extends SQLite3 {
            function __construct() {
                $this->open('mysqlitedb.db');
            }
        }
        $db = new MyDB();
        if(!$db) {echo "Error : ",$db->lastErrorMsg();}
        else {echo " Successful ";}
    ?>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST"){
      echo " ::::: Authentification : ";
      $usr = test_input($_POST["usr"]);
      $pwd = test_input($_POST["pwd"]);

      $admin_query = "select * from admin where acct = '" .$usr . "'";
      $bank_query_response = $db->querySingle($admin_query,TRUE);
      if(!$bank_query_response){
          echo  " Wrong Admin Account </h4><br>";
      }
      else{
          //var_dump($bank_query_response);
          $usr_pwd = $bank_query_response['pwd'];
          if($pwd!=$usr_pwd){
              echo " Wrong Admin Account/Password  </h4><br>";
          }
          if($pwd==$usr_pwd){
              echo " Successful  </h4><br>";
              echo "
              <h3>All Registrations:</h3>
              <table class='table table-striped'>
              <thead>
                <tr>
                    <th>Name</th>
                    <th>adress</th>
                    <th>Email</th>
                    <th>Mob No.</th>
                    <th>Acct No.</th>
                </tr>
              </thead>
              <tbody>  ";
              $results = $db->query('SELECT * FROM reg_data');
              while ($row = $results->fetchArray()) {
                  echo "<tr><td>",$row[0],"</td><td>",$row[1], "</td><td>",$row[2],"</td>";
                  echo "<td>",$row[3],"</td><td>",$row[4], "</td></tr>";
                 // echo "<br> $row[0] $row[1] $row[2] $row[3] $row[4]";
              }

          }
      }

    }


function test_input($data) {
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}

?>


</body>
</html>
