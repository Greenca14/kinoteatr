<?php
session_start(["use_strict_mode" => true]);
require('database2.php');
if (isset($_GET['reg'])){
    if (isset($_FILES['addfile'])) {
        $fp = fopen($_FILES['addfile']['tmp_name'], 'rb');
        $bin_img = base64_encode(fread($fp, $_FILES['addfile']['size']));
        fclose($fp);
    } else {
        $bin_img = 'NULL';
    }

    $user_id_query = $db->query("SELECT MAX(\"id\") FROM \"kinoteatr1\".\"Пользователи\"");
    $user_id = $user_id_query->fetch();
    $creds_query = $db->query("INSERT INTO kinoteatr1.\"Пользователи\" VALUES (".($user_id['max']+1).", '".$_POST['login']."', '".$_POST['password']."', '".$bin_img."')");
    $_SESSION['username'] = $_POST['login'];
    $_SESSION['user_id'] = $user_id['max'];
    $_SESSION['pfp'] = $bin_img;
    header("Location: /profile.php");
    die();
}
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