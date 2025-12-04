<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Reporter Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #FFF6F2;
        }

        /* Sidebar */
        .sidebar {
            width: 220px;
            background: #FFE5DB;
            height: 100vh;
            position: fixed;
            padding-top: 20px;
            left: 0;
            top: 0;
        }

        .sidebar a {
            display: block;
            padding: 12px 20px;
            color: #333;
            font-weight: bold;
            text-decoration: none;
        }

        .sidebar a:hover {
            background: #FF6A3D;
            color: white;
        }

        /* Header */
        .header {
            margin-left: 220px;
            padding: 15px 25px;
            background: white;
            border-bottom: 2px solid #FFE5DB;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 10;
        }

        /* Content */
        .content {
            margin-left: 220px;
            padding: 25px;
        }

        h2 {
            margin-top: 0;
        }

        /* Add Button */
        .btn-add {
            padding: 10px 18px;
            background: #FF6A3D;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: bold;
            transition: 0.2s;
        }

        .btn-add:hover {
            background: #D93A20;
        }

        /* Table */
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 3px 8px rgba(0,0,0,0.12);
        }

        th {
            background: #FFE5DB;
            padding: 14px;
            font-weight: bold;
            font-size: 15px;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #eee;
            font-size: 14px;
        }

        tr:hover {
            background: #FFF1EB;
        }

        td img {
            width: 90px;
            border-radius: 6px;
        }

        /* Buttons */
        .btn {
            padding: 6px 10px;
            color: white;
            border-radius: 6px;
            text-decoration: none;
            font-size: 13px;
        }

        .edit { background: #FF8A50; }
        .edit:hover { background: #D96B35; }

        .delete { background: #D93A20; }
        .delete:hover { background: #A82C18; }

        /* Empty state */
        .empty-row td {
            text-align: center;
            padding: 20px;
            color: #555;
            font-style: italic;
            background: #FFF1EB;
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

<!-- Header -->
<div class="header">
    <h2>
        Xin chào, phóng viên 
        <b>${sessionScope.user.fullname}</b>
    </h2>
    <a href="${pageContext.request.contextPath}/logout" style="color:#FF6A3D;">Đăng xuất</a>
</div>
<div class="content">
    <h2>Bài viết của tôi</h2>

    <div style="text-align:right; margin-bottom: 15px;">
        <a class="btn-add" href="${pageContext.request.contextPath}/reporter/news?action=add">
            + Thêm tin mới
        </a>
    </div>

    <table>
        <tr>
            <th style="width:120px;">Ảnh</th>
            <th>Tiêu đề</th>
            <th style="width:140px;">Ngày đăng</th>
            <th style="width:100px;">Lượt xem</th>
            <th style="width:150px;">Hành động</th>
        </tr>

        <c:if test="${empty myNews}">
            <tr class="empty-row">
                <td colspan="5">
                    Bạn chưa có bài viết nào. Hãy bấm <b>“Thêm tin mới”</b> để bắt đầu.
                </td>
            </tr>
        </c:if>

        <c:forEach var="n" items="${myNews}">
            <tr>
                <td><img src="${pageContext.request.contextPath}/${n.image}" alt="Ảnh"></td>
                <td>${n.title}</td>
                <td>${n.createdAt}</td>
                <td style="text-align:center;">${n.views}</td>
                <td>
                    <a class="btn edit"
                       href="${pageContext.request.contextPath}/reporter/news?action=edit&id=${n.id}">
                        Sửa
                    </a>
                    <a class="btn delete"
                       href="${pageContext.request.contextPath}/reporter/news?action=delete&id=${n.id}"
                       onclick="return confirm('Bạn có chắc muốn xóa bài viết này?')">
                        Xóa
                    </a>
                </td>
            </tr>
        </c:forEach>

    </table>
</div>


</body>
</html>
