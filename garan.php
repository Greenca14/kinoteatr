<?php
session_start();?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400&display=swap" rel="stylesheet">
    <title>Cinema</title>
    <meta charset="UTF-8">
    <style>
        *{
            box-sizing: border-box;
        }
        body {
            padding: 0;
            margin: 0;
            background-color: #eaeaea;
        }

        .card{
            padding: 20px;
            background: white;
            border-radius: 20px;
            margin-top: 20px;
            font-family: 'Montserrat', sans-serif;
            width: 350px;
        }

        .card2{
            padding: 20px;
            background: white;
            border-radius: 20px;
            margin-top: 20px;
            font-family: 'Montserrat', sans-serif;
            width: 800px;
        }

        .card-title{
            font-size: 18px;
            font-weight: bold;
            font-family: 'Montserrat', sans-serif;
        }


        .container{
            padding: 10px;
            background-image: url("fonkino.jpg");
            background-repeat: no-repeat;
            height: calc(90vh - 26px);
            background-size: cover;
        }

        .texthold{
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 60px;
            flex-wrap: wrap;
        }

        .top > * {
            margin: 0;
        }

        .top{
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            gap: 10px;
            background-color: black;
            padding: 15px;
        }
        .toptext{
            color: white;
            font-family: 'Montserrat', sans-serif;
        }
        .another_text{
            position: absolute;
            left: 82%;
            top: 90%;
            font-family: 'Montserrat', sans-serif;
            color: white;
        }

    </style>
</head>
<body>
<div class="top" >
    <h1 class="toptext">Поиск дешевых билетов в Кино</h1>
    <p class="toptext" >Лучший агрегатор для поиска билетов</p>
    <?php if (!isset($_SESSION['username'])): ?>
        <a href="login.php" class="toptext" > Войти в личный кабинет </a>
    <?php else: ?>
        <a href="profile.php" style="text-decoration: none" class="toptext" >Личный кабинет: <?php echo $_SESSION['username']; ?></a>
    <?php endif; ?>
</div>
<div class="container">
    <div class="texthold">
        <div class="card2">
            <div class="card-title">
                Гарантии
            </div>
            <div class="card-body">
                <p>Как агрегатор билетов в кино, мы гарантируем следующее:</p>

                <p>Полная прозрачность: Мы гарантируем полную прозрачность в отношении наших цен, платежей и услуг. Мы предоставляем точную информацию о стоимости билетов, дополнительных услугах, а также ясную информацию о наших правилах и условиях.</p>

                <p>Удобство и доступность: Мы гарантируем, что наши услуги доступны для всех пользователей. Мы предлагаем широкий выбор опций покупки билетов, включая онлайн-бронирование, посредством мобильных приложений и через нашу контактную службу. Мы также гарантируем, что наши пользователи получат максимальный комфорт и удобство во время просмотра фильма.</p>

                <p>Клиентоориентированность: Мы гарантируем высокий уровень обслуживания и поддержки для наших пользователей. Мы предоставляем профессиональную помощь при вознмкновении каких-либо неудобств</p>

                <p>Мы гордимся нашей надежной репутацией и всегда готовы предоставить нашим пользователям высококачественные услуги.</p>
            </div>
        </div>

        <div class="card">
            <div class="card-title">
                <a href="index.php"> Вернуться обратно</a>
            </div>
        </div>
        <div class="another_text">
            <h3>Контактный номер: 8922423123</h3>
        </div>
    </div>
</body>
</html>