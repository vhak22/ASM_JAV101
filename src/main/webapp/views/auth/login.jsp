<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng nhập - ABC News</title>

    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Inter', sans-serif;
            background: #FFF6F2;
        }

        .login-container {
            width: 100%;
            max-width: 430px;
            margin: 80px auto;
            padding: 30px;
            background: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #D93A20;
            margin-bottom: 20px;
            font-size: 26px;
        }

        .form-group {
            margin-bottom: 20px;
            width: 100%;
        }

        label {
            font-weight: 600;
            color: #333;
            margin-bottom: 6px;
            display: block;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 12px 14px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            transition: 0.2s;
        }

        input:focus {
            border-color: #D93A20;
            outline: none;
            box-shadow: 0 0 0 3px rgba(217,58,32,0.2);
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            background: #D93A20;
            border: none;
            border-radius: 8px;
            color: white;
            cursor: pointer;
            font-weight: 600;
            transition: 0.2s;
        }

        .btn-login:hover {
            background: #FF6A3D;
        }

        .error {
            background: #ffe1e1;
            padding: 10px;
            border-left: 4px solid #e60000;
            margin-bottom: 18px;
            color: #b30000;
            border-radius: 6px;
        }

        .note {
            text-align: center;
            margin-top: 15px;
            color: #666;
            font-size: 14px;
        }
    </style>
</head>

<body>

<div class="login-container">

    <h2>Đăng nhập hệ thống</h2>

    <!-- HIỂN THỊ LỖI -->
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <div class="form-group">
            <label>Tài khoản</label>
            <input type="text" name="id" placeholder="Nhập ID..." required>
        </div>

        <div class="form-group">
            <label>Mật khẩu</label>
            <input type="password" name="password" placeholder="Nhập mật khẩu..." required>
        </div>

        <button type="submit" class="btn-login">Đăng nhập</button>
    </form>

    <p class="note">Lều Báo – Lan tỏa giá trị tốt đẹp</p>
</div>

</body>
</html>
