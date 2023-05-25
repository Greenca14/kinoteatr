<?php
session_start(["use_strict_mode" => true]);
require('database2.php');

if (isset($_POST['login'])){
    $result = $db->query("SELECT * FROM \"kinoteatr1\".\"Пользователи\" WHERE \"login\" = '".$_POST['login']."'");


    if ($row = $result->fetch())
    {
        if (($_POST["password"]) == $row['password']){
            $_SESSION['username'] = $row['login'];
            $_SESSION['user_id'] = $row['ID_AC'];
            header("Location: ../profile.php");
            die();
        }
        else {
            $_SESSION['message'] = 'Вы ввели неправильный пароль!';
            header("Location: ../login.php");
            die();
        }

    }
    else {
        $_SESSION['message'] = 'Вы ввели неправильный логин!';
        header("Location: ../login.php?");
        die();
    }

}
if ($_GET['logout'] == 1){
    session_unset();
    header("Location: ../login.php");
    die();
}