<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý danh mục</title>

<style>
    .form-container {
        max-width: 600px;
        margin: 40px auto;
        background: #ffffff;
        padding: 30px 35px;
        border-radius: 18px;
        box-shadow: 0 4px 14px rgba(0,0,0,0.12);
    }

    .form-title {
        text-align: center;
        font-size: 26px;
        font-weight: 700;
        color: #D93A20;
        margin-bottom: 25px;
    }

    label {
        font-weight: 600;
        margin-bottom: 6px;
        display: block;
    }

    input[type="text"] {
        width: 100%;
        padding: 12px;
        border-radius: 10px;
        border: 1px solid #ccc;
        font-size: 15px;
        margin-bottom: 22px;
    }

    input[type="text"]:focus {
        outline: none;
        border-color: #D93A20;
        box-shadow: 0 0 5px rgba(217, 58, 32, 0.4);
    }

    .btn-save {
        background: #D93A20;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 10px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
    }

    .btn-back {
        background: #ccc;
        padding: 10px 20px;
        border-radius: 10px;
        text-decoration: none;
        color: #333;
        margin-left: 8px;
        font-size: 15px;
        font-weight: 600;
    }

    .btn-save:hover { opacity: 0.85; }
    .btn-back:hover { background: #bcbcbc; }
</style>

</head>
<body>

<jsp:include page="layout-admin.jsp" />

<div class="content">
    <div class="form-container">

        <h2 class="form-title">
            <c:choose>
                <c:when test="${not empty category}">✏️ Sửa danh mục</c:when>
                <c:otherwise>➕ Thêm danh mục</c:otherwise>
            </c:choose>
        </h2>

        <form method="post" action="${pageContext.request.contextPath}/admin/category">

            <!-- Mã danh mục -->
            <label>Mã danh mục</label>
            <input type="text" name="id" value="${category.id}"
                <c:if test='${not empty category}'>readonly</c:if>
                placeholder="VD: C01" required>

            <!-- Tên danh mục -->
            <label>Tên danh mục</label>
            <input type="text" name="name" value="${category.name}" 
                placeholder="Tên danh mục..." required>

            <!-- Buttons -->
            <button class="btn-save" type="submit">Lưu</button>
            <a class="btn-back" href="${pageContext.request.contextPath}/admin/category">Quay lại</a>
        </form>

    </div>
</div>

</body>
</html>
