<html>
<body>
<h1>This php file creates database tables and field if it don't exists.</h1>
<br>

<h4> Database Status :
<?php
// open the database, a file named mysqlitedb.db should exist
class MyDB extends SQLite3 {
    function __construct() {
        $this->open('mysqlitedb.db');
    }
}
$db = new MyDB();
if(!$db) {
    echo $db->lastErrorMsg();
}
else {
    echo "Opened successfully";
}
?>
</h4
<br>
<h4> Registration Table :

<?php
// adding registration tables if not exist
$create_reg_table = $db->exec(
"CREATE TABLE IF NOT EXISTS reg_data (
    usr  TEXT NOT NULL,
    addr  TEXT  NOT NULL,
    mail  TEXT NOT NULL,
    mob   INTEGER NOT NULL,
    acct INTEGER NOT NULL)"
);
if(!$create_reg_table){
      echo $db->lastErrorMsg();
} else {
    echo "Exists";
}

?>
</h4>

<h4>Bank Table :
<?php
 // adding bank table if not EXISTS
 $create_bank_table = $db->exec(
 "CREATE TABLE IF NOT EXISTS bank (
     acct  INTEGER PRIMARY KEY,
     pwd  TEXT    NOT NULL,
     bal  INTEGER NOT NULL)"
 );
 if(!$create_bank_table){
       echo " Error : ", $db->lastErrorMsg();
 } else {
     echo " Exists";
}
echo "<br><br> Insert Bank Accounts :";
$sql =<<<EOF
      INSERT INTO bank (acct,pwd,bal)
      VALUES (12345, 'pass' , 10000);

      INSERT INTO bank (acct,pwd,bal)
      VALUES (12121, 'pass' , 5000);

      INSERT INTO bank (acct,pwd,bal)
      VALUES (54321, 'pass' , 800);
EOF;

$insert = $db->exec($sql);
if(!$insert) {
  echo " Error : ", $db->lastErrorMsg();
} else {
  echo "Successful";
}

?>
</h4>
<h4>Admin Table:
<?php
$create_admin_table = $db->exec(
"CREATE TABLE IF NOT EXISTS admin (
    acct  Text PRIMARY KEY,
    pwd  TEXT    NOT NULL)"
);
if(!$create_admin_table){
      echo " Error : ", $db->lastErrorMsg();
} else {
    echo " Exists";
}

echo "<br><br> Insert Admin Accounts :";
$sql =<<<EOF
      INSERT INTO admin (acct,pwd)
      VALUES ('aasis21', 'pass1234');

      INSERT INTO admin (acct,pwd)
      VALUES ('kk', 'pass');
EOF;

$insert = $db->exec($sql);
if(!$insert) {
  echo " Error : ", $db->lastErrorMsg();
} else {
  echo "Successful";
}

 ?>
</h4>

</body>
</html>
