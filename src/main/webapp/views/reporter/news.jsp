<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm / Sửa Tin</title>

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
            top: 0;
            left: 0;
        }

        .sidebar a {
            display: block;
            padding: 12px 20px;
            font-weight: bold;
            text-decoration: none;
            color: #333;
        }

        .sidebar a:hover {
            background: #FF6A3D;
            color: white;
        }

        /* Content */
        .content {
            margin-left: 220px;
            padding: 30px;
        }

        /* Form */
        .form-box {
            background: white;
            width: 600px;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.12);
        }

        input, textarea, select {
            width: 100%;
            padding: 12px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
        }

        label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
        }

        button {
            background: #FF6A3D;
            padding: 12px 20px;
            border-radius: 8px;
            border: none;
            font-size: 16px;
            color: white;
            cursor: pointer;
            font-weight: bold;
        }

        button:hover {
            background: #D93A20;
        }
    </style>
</head>

<body>

<!-- SIDEBAR -->
<div class="sidebar">
    <a href="${pageContext.request.contextPath}/views/reporter/dashboard.jsp">📰 Bảng tin của tôi</a>
    <a href="${pageContext.request.contextPath}/reporter/profile">👤 Hồ sơ cá nhân</a>
    <a href="${pageContext.request.contextPath}/views/home/index.jsp">🏠 Trang chủ</a>
    <a href="${pageContext.request.contextPath}/logout">🚪 Đăng xuất</a>
</div>

<!-- CONTENT -->
<div class="content">

    <h2>${empty news ? "Thêm bài viết mới" : "Sửa bài viết"}</h2>

    <div class="form-box">

        <!-- FORM -->
        <form action="${pageContext.request.contextPath}/reporter/news" method="post">

            <!-- Nếu là EDIT thì gửi kèm ID -->
            <c:if test="${not empty news}">
                <input type="hidden" name="id" value="${news.id}">
                <input type="hidden" name="action" value="update">
            </c:if>

            <c:if test="${empty news}">
                <input type="hidden" name="action" value="insert">
            </c:if>

            <label>Tiêu đề:</label>
            <input type="text" name="title" value="${news.title}" required>

            <label>Nội dung:</label>
            <textarea name="content" rows="7" required>${news.content}</textarea>

            <label>Ảnh (Image):</label>
            <input type="text" name="image" value="${news.image}" placeholder="vd: img1.jpg" required>

            <label>Danh mục (Category):</label>
            <select name="categoryId" required>
                <c:forEach var="c" items="${categories}">
                    <option value="${c.id}"
                        <c:if test="${news.categoryId == c.id}">selected</c:if>>
                        ${c.name}
                    </option>
                </c:forEach>
            </select>

            <label>Tin nổi bật:</label>
            <select name="home">
                <option value="0" ${news.home == 0 ? "selected" : ""}>Không</option>
                <option value="1" ${news.home == 1 ? "selected" : ""}>Có</option>
            </select>

            <button type="submit">Lưu bài viết</button>
        </form>
    </div>

</div>

</body>
</html>
