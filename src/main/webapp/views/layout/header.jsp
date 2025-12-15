<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<fmt:setBundle basename="messages" />
    
<!DOCTYPE html>
<html>
<head>
<style>
    /* ===========================
       HEADER STYLE (giống index.jsp)
       =========================== */
    .header {
        background: #D93A20;
        color: #fff;
        padding: 15px 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        font-size: 20px;
        font-family: 'Inter', sans-serif;
    }

    .nav a {
        color: #fff;
        margin-left: 25px;
        text-decoration: none;
        font-size: 16px;
        font-weight: 500;
        transition: 0.2s;
    }

    .nav a:hover {
        opacity: 0.75;
    }

    .nav span {
        margin-left: 20px;
        font-size: 15px;
        opacity: 0.9;
    }
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<div class="header">
	<a href="${pageContext.request.contextPath}//home" style = "text-decoration: none; color: #FFF;">
    	<div><b>ABC News ${a}</b></div>	
	</a>
    <div class="nav">
<!--    <a href="${pageContext.request.contextPath}/home"><fmt:message key="menu.home"/></a>
	    <span style="margin-left: 15px;">
	        <a href="${pageContext.request.contextPath}/language?lang=vi" 
	           style="color: ${sessionScope.lang == 'en' ? '#ccc' : 'yellow'}; margin:0 5px;">VN</a> 
	        |
	        <a href="${pageContext.request.contextPath}/language?lang=en" 
	           style="color: ${sessionScope.lang == 'en' ? 'yellow' : '#ccc'}; margin:0 5px;">EN</a>
	    </span>  -->	
        <a href="${pageContext.request.contextPath}//home">Trang chủ</a>
		<a href="${pageContext.request.contextPath}/category?id=TEC">Công nghệ</a>
		<a href="${pageContext.request.contextPath}/category?id=SPO">Thể Thao</a>
		<a href="${pageContext.request.contextPath}/category?id=ENT">Giải trí</a>
		<a href="${pageContext.request.contextPath}/category?id=SOC">Xã hội</a>
        <a href="${pageContext.request.contextPath}/contact">Liên hệ</a>

        <!-- =======================
             1. CHƯA ĐĂNG NHẬP
        ========================== -->
        <c:if test="${empty sessionScope.user}">
            <a href="${pageContext.request.contextPath}/login">Đăng nhập</a>
        </c:if>

        <!-- =======================
             2. ĐÃ ĐĂNG NHẬP
        ========================== -->
        <c:if test="${not empty sessionScope.user}">

            <!-- Chào người dùng -->
            <span style="margin-left:20px; color:yellow;">
                Xin chào, ${sessionScope.user.fullname}
            </span>

            <!-- ADMIN (role = true) -->
            <c:if test="${sessionScope.user.role == true}">
                <a href="${pageContext.request.contextPath}/admin/dashboard">
                    Quản trị hệ thống
                </a>
            </c:if>

            <!-- PHÓNG VIÊN (role = false) -->
            <c:if test="${sessionScope.user.role == false}">
                <a href="${pageContext.request.contextPath}/reporter/dashboard">
                    Trang phóng viên
                </a>
            </c:if>

            <!-- Logout -->
            <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>

        </c:if>
    </div>
</div>

</body>
</html>