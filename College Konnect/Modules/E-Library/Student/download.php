<?php
	include("../../../includes/session.php");
	include("../../../includes/functions.php");
	include("../../../includes/config.php");

	$id = $_GET['id'];
          $query = "SELECT * " ."FROM files WHERE categoryid = '$id' and category='library'";
          $result = mysqli_query($db,$query) 
                     or die('Error, query failed');
         list($id, $user, $file, $type, $size,$content) =   mysqli_fetch_array($result);
           //echo $id . $file . $type . $size;
         header("Content-length: $size");
         header("Content-type: $type");
         header("Content-Disposition: attachment; filename=$file");
         ob_clean();
         flush();
         echo $content;
         mysqli_close($connection);
         exit;
?>