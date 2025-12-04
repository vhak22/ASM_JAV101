<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ phóng viên</title>

    <style>
        body {
            margin: 0;
            font-family: Arial;
            background: #FFF6F2;
        }

        .sidebar {
            width: 220px;
            background: #FFE5DB;
            height: 100vh;
            position: fixed;
            padding-top: 20px;
        }

        .sidebar a {
            display: block;
            padding: 12px 20px;
            text-decoration: none;
            font-weight: bold;
            color: #333;
        }

        .sidebar a:hover {
            background: #FF6A3D;
            color: white;
        }

        .content {
            margin-left: 220px;
            padding: 25px;
        }

        form {
            background: white;
            padding: 20px;
            width: 400px;
            border-radius: 12px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        input {
            width: 100%;
            padding: 10px;
            margin-bottom: 12px;
            border-radius: 6px;
            border: 1px solid #ddd;
        }

        button {
            background: #FF6A3D;
            color: white;
            padding: 10px 14px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
        }
    </style>
</head>

<body>
<!-- Sidebar -->
<div class="sidebar">
    <a href="${pageContext.request.contextPath}/views/reporter/dashboard.jsp">📰 Bảng tin của tôi</a>
    <a href="${pageContext.request.contextPath}/reporter/profile">👤 Hồ sơ cá nhân</a>
    <a href="${pageContext.request.contextPath}/views/home/index.jsp">🏠 Trang chủ</a>
    <a href="${pageContext.request.contextPath}/logout">🚪 Đăng xuất</a>
</div>

<div class="content">
    <h2>Hồ sơ cá nhân</h2>

    <form action="profile" method="post">
        <label>Tên đăng nhập</label>
        <input type="text" name="username" value="${user.fullname}" required>

        <label>Mật khẩu</label>
        <input type="password" name="password" value="${user.password}" required>

        <button type="submit">Cập nhật</button>
    </form>
</div>

</body>
</html>
