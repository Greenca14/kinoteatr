<?php

session_start(["use_strict_mode" => true]);
require_once "database.php";

try {
    $db = new PDO("pgsql:host=$host;port=$port;dbname=$db_name", $user, $pwd);
} catch (PDOException $e) {
    die("Couldn't connect to the database $db_name: " . $e->getMessage());
}