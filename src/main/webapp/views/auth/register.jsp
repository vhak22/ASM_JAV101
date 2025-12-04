<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập – ABC News</title>
    <style>
        body {
            font-family: Inter, sans-serif;
            background: #FFF6F2;
            margin: 0; padding: 0;
        }
       .register-container {
            width: 420px;
            margin: 70px auto;
            padding: 30px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #D93A20;
        }
        input {
            width: 100%;
            padding: 12px;
            margin: 8px 0 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        .btn {
            width: 100%;
            padding: 12px;
            background: #D93A20;
            border: none;
            color: #fff;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
        }
        .btn:hover {
            background: #FF6A3D;
        }
        .msg {
            color: red;
            text-align: center;
            margin-bottom: 10px;
        }
        .link {
            text-align: center;
            margin-top: 12px;
        }
        a { color: #D93A20; text-decoration: none; }
    </style>
</head>
<body>

<div class="register-container">
    <h2>Đăng nhập</h2>

    <!-- Thông báo lỗi -->
    <c:if test="${not empty message}">
        <div class="msg">${message}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <input type="text" name="email" placeholder="Email" required />

        <input type="password" name="password" placeholder="Mật khẩu" required />

        <button class="btn" type="submit">Đăng nhập</button>
    </form>

    <div class="link">
        Chưa có tài khoản?
        <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
    </div>
</div>

</body>
</html>
