<?php
header("Cache-Control: no-store, no-cache, must-revalidate, max-age=0");
header("Cache-Control: post-check=0, pre-check=0", false);
header("Pragma: no-cache");

$con = mysqli_connect("localhost", "root", "", "grocery_db");
// Check connection
if (mysqli_connect_errno()) {
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
    exit();
}

$sql = "SELECT products.pid, 
               products.name, 
               products.quantity, 
               products.price, 
               categories.name AS category,
               products.image_url
        FROM products
        INNER JOIN categories ON products.cid = categories.cid";

if ($result = mysqli_query($con, $sql)) {
    $emparray = array();
    while ($row = mysqli_fetch_assoc($result)) {
        $emparray[] = $row;
    }
    echo json_encode($emparray);
    mysqli_free_result($result);
} else {
    echo json_encode(["error" => "Failed to fetch data"]);
}

mysqli_close($con);
?>
