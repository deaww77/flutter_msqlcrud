<?php
include 'db.php';

$result = $conn->query("SELECT id, name, email FROM users ORDER BY id DESC");

$users = [];
while ($row = $result->fetch_assoc()) {
    $users[] = $row;
}

echo json_encode($users);
?>
