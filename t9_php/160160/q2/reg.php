<!DOCTYPE html>
<html lang="en">
<head>
  <title>Lets Build Stuff!</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
</head>
<body>

<div class="container">

  <h2>Lets Build Stuff!! <a href="form.html" class="btn btn-default"> Another Registrations</a> </h2>
  <p><i>An Exicting Event Hosted by Students of CS251.</i></p>

  <h4 > Database Status:
  <?php
      // open the database, a file named mysqlitedb.db should exist
      class MyDB extends SQLite3 {
          function __construct() {
              $this->open('mysqlitedb.db');
          }
      }
      $db = new MyDB();
      if(!$db) {echo "Error : ",$db->lastErrorMsg(),"</h4><br>";}
      else {echo " Successful </h4><br>";}
  ?>

<?php

if ($_SERVER["REQUEST_METHOD"] == "POST"){

  $usr = test_input($_POST["usr"]);
  $mail = test_input($_POST["mail"]);
  $addr = test_input($_POST["addr"]);
  $mob = test_input($_POST["mob"]);
  $acct = test_input($_POST["acct"]);
  $pwd = test_input($_POST["pwd"]);

  $qstr = "insert into reg_data values ('$usr', '$addr', '$mail', '$mob', '$acct')";

  //echo "<br>checking mail_constraint";
  $mail_constraint = 1;
  $mail_query = "select * from reg_data where mail = '" .$mail ."'" ;
  $mail_query_response = $db->query($mail_query);
  if (!$mail_query_response){
      echo "<h4>There was an error in query: $usr_query </h4>";
      echo $db->lastErrorMsg();
  }
  else{
      //echo "<br>Query successful : $mail - mail count : ";
      $count = 0;
      while ($row = $mail_query_response->fetchArray()) {
          $count = $count +1 ;
          //var_dump($row);
      }
      //echo $count;
      if($count){
          $mail_constraint = 0;
      }
  }

  if($mail_constraint){
      //echo  "<br>checking bank constraint<br>";
      $bank_contraint=0;
      $bank_query = "select * from bank where acct = '" .$acct . "'";
      $bank_query_response = $db->querySingle($bank_query,TRUE);
      if(!$bank_query_response){
          echo  "<h4>Wrong Account, Aborting Registration!!</h4>";
      }
      else{
          //var_dump($bank_query_response);
          $bank_pwd = $bank_query_response['pwd'];
          $bank_bal = $bank_query_response['bal'];
          if($pwd!=$bank_pwd){
              echo  "<h4>Wrong Account/Password, Aborting Registration!!</h4>";
          }
          if($pwd==$bank_pwd){
              if($bank_bal<1000){
                  echo  "<h4>Insufficient Account Balance, Aborting Registration!!</h4>";
              }
              else{
                  $bank_bal = $bank_bal - 1000;
                  $update_bal_query = "update bank set bal =". $bank_bal . " where acct = " . $acct ." ";
                  $update_bal = $db->exec($update_bal_query);
                   if(!$update_bal) {
                      echo "<h4>Transaction Failed : ", $db->lastErrorMsg(), "</h4>";
                   } else {
                      echo "<h4>Transaction Successful </h4>";
                   }
                  $bank_contraint=1;
              }
          }
      }


      if($bank_contraint){
          $insres = $db->query($qstr);
          if(!$insres) {
              echo $db->lastErrorMsg();
           } else {
              echo "<h4>Congrats, Registration Successful<h4>";
           }
      }
      else{
          //echo "<br>unsuccessful<br>";
      }
  }
  else{
      echo "<h4>EMAIL ID ALREADY EXIST, ABORT REGISTRATION </h4>";
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
