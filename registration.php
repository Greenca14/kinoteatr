<?php
require_once ("database2.php");

if (isset($_SESSION['message']))
    echo($_SESSION['message']);
unset($_SESSION['message']);
?>

<style>
    .auth-form {
        display: flex;
        flex-direction: column;
        align-items: center;

    }
    .color{
        display: flex;
        flex-direction: column;
        align-items: center;
        color: white;
    }
    .container{
        margin: -8px;
        padding: 49px;
        background-image: url("fonkino.jpg");
        background-repeat: no-repeat;
        height: calc(100vh - 98px);
        background-size: cover;
    }
    form {
        display: flex;
        flex-direction: column;
        align-items: start;
        margin-bottom: 20px;
        padding: 20px;
        background-color: #f2f2f2;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }
    input[type="text"],
    input[type="password"] {
        width: 100%;
        margin-bottom: 15px;
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
        font-size: 16px;
    }
    input[type="submit"] {
        width: 100%;
        background-color: plum;
        color: white;
        padding: 12px 20px;
        margin-top: 10px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }
    input[type="submit"]:hover {
        background-color: mediumpurple;
    }
    input[type="button"] {
        width: 100%;
        background-color: plum;
        color: white;
        padding: 12px 20px;
        margin-top: 10px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }
    input[type="button"]:hover {
        background-color: mediumpurple;
    }
    button {
        background-color: coral;
        border: none;
        color: white;
        padding: 12px 20px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }
    button:hover {
        background-color: tomato;
    }
    a {
        color: whitesmoke;
        font-size: 16px;
        text-decoration: none;
    }
    a:hover {
        text-decoration: underline;
    }

</style>
<div class="container">
    <h1 class="color">Регистрация</h1>
    <div class="auth-form">
        <form action="authentic.php?reg" method="POST" enctype="multipart/form-data">
            <input required type="file" name="addfile" value="Загрузите аватарку" accept=".png">
            <input type="text" name="login" required placeholder="Логин">
            <input type="password" name="password" required placeholder="Пароль">
            <input type="submit" name="sender" value="Зарегестрироваться">
            <input onclick="location.href = 'http://kinoteatr/login.php';" type="button" value="Войти">
        </form>

        <?php if (!isset($_SESSION['username'])): ?>
            <!--        <button> <a href="reg.php">Зарегистрироваться</a></button>-->
        <?php else: ?>
            <button ><a href="authentic.php?logout=1">Выйти из учетной записи</a></button>
        <?php endif; ?>
        <button> <a href="index.php">Вернуться на главную</a> </button>
    </div>

</div>
