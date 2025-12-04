<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liên hệ – ABC News</title>

    <style>
        body { font-family: Arial; background:#FFF6F2; margin:0; }
        header { background:#D93A20; padding:15px; color:white; }
        .category-container {
            width:500px; margin:40px auto; background:white;
            padding:25px; border-radius:12px;
            box-shadow:0 2px 6px rgba(0,0,0,0.15);
        }
        input, textarea {
            width:100%; padding:12px; margin-bottom:12px;
            border-radius:8px; border:1px solid #ccc;
        }
        button {
            background:#FF6A3D; border:none; color:white;
            padding:12px 20px; border-radius:10px;
            cursor:pointer; font-size:16px;
        }
    </style>
</head>
<body>

<header>
    <h2>ABC News – Liên hệ</h2>
</header>

<div class="category-container">

    <h2 style="color:#D93A20;">Gửi phản hồi</h2>

    <form>
        <input type="text" placeholder="Họ và tên">
        <input type="email" placeholder="Email">
        <textarea rows="5" placeholder="Nội dung"></textarea>
        <button>Gửi thông tin</button>
    </form>

</div>

</body>
</html>
