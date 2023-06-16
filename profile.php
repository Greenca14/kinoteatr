<?php
session_start();

if (!isset($_SESSION['username'])) {
    header("Location: login.php");
    exit();
}

if ($_SESSION['pfp'] != 'NULL') {
    $pfp = 'data:image/png;base64,'.$_SESSION['pfp'];
} else {
    $pfp = './user.png';
}

?>

<!DOCTYPE html>

<style>
    body {
        font-family: "Montserrat", sans-serif;
        font-size: 16px;
    }
    .container{
        margin: -8px;
        padding: 49px;
        background-image: url("fonkino.jpg");
        background-repeat: no-repeat;
        height: calc(100vh - 98px);
        background-size: cover;
    }
    .center{
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    h1, h2 {
        color: black;
        line-height: 0.5;
    }

    h3 {
        color: black;
        line-height: 0.5;
    }

    form {
        display: flex;
        flex-direction: column;
        align-items: center;
        margin-bottom: 20px;
        padding: 20px;
        background-color: #f2f2f2;
        border-radius: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }

    input[type=submit] {
        background-color: plum;
        border: none;
        color: #fff;
        font-size: 16px;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        margin: 4px 2px;
        cursor: pointer;
    }

    input[type=submit]:hover {
        background-color: mediumpurple;
    }
    button {
        background-color: plum;
        border: none;
        color: white;
        font-size: 16px;
        padding: 10px 20px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        margin: 4px 2px;
        cursor: pointer;
    }
    button:hover {
        background-color: mediumpurple;
    }
    a {
        color: white;
    }
    .image{
        max-width: 150px;
    }
</style>

<html>
<head>
    <title>Личный кабинет</title>
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<div class="container">
    <div class="center">
        <form action="authentic.php" method="get">
        <h1>Личный кабинет</h1>
            <img class="image" src="<?php echo $pfp; ?>">
        <h2>Информация о пользователе:</h2>
        <h3>Имя пользователя: <?php echo $_SESSION['username']; ?></h3>
            <div class="center">
                <input type="hidden" name="logout" value="1" />
                <input type="submit" value="Выйти" />

                <div>
                    <button> <a href="index.php" style="text-decoration: none"> На главную </a> </button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>