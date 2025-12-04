<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<style>
    /* FOOTER STYLE – giống index.jsp */
    footer {
        background: #1F1F1F;
        color: #fff;
        padding: 40px 0;
        
        font-family: 'Inter', sans-serif;
    }

    .footer-container {
        max-width: 1200px;
        margin: auto;
        display: flex;
        justify-content: space-between;
        flex-wrap: wrap;
        gap: 30px;
    }

    .footer-block h3 {
        margin-bottom: 12px;
        font-size: 18px;
    }

    .footer-block p {
        margin: 6px 0;
        opacity: 0.85;
        font-size: 15px;
    }

    .footer-block p:hover {
        opacity: 1;
    }
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<footer>
    <div class="footer-container">

        <div class="footer-block">
            <h3>ABC NEWS</h3>
            <p>Nguồn tin tức chính xác – nhanh chóng – đa chiều.</p>
        </div>

        <div class="footer-block">
            <h3>Liên kết nhanh</h3>
            <p><a href="${pageContext.request.contextPath}/home" style="color:white; text-decoration:none;">Trang chủ</a></p>
            <p><a href="${pageContext.request.contextPath}/contact" style="color:white; text-decoration:none;">Liên hệ</a></p>
            <p>Chính sách bảo mật</p>
        </div>

        <div class="footer-block">
            <h3>Theo dõi chúng tôi</h3>
            <p>Facebook | YouTube | Twitter</p>
        </div>

    </div>
</footer>
</body>
</html>