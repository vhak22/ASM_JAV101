<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<c:import url="../layout/header.jsp" />


<div class="category-container">

    <h2 style="color:#D93A20;">Gửi thông tin liên hệ</h2>

    <form action="${pageContext.request.contextPath}/contact" method="post">
        <input type="text" name="subject" placeholder="Tiêu Đề" required>
        <input type="email" name="to" placeholder="email" required>
        <textarea rows="5" name="content" placeholder="Nội dung" required></textarea>
        <button type="submit" >Gửi thông tin</button>
        <button type="reset" >Xóa</button>
        <mark >${message}</mark>
    </form>

</div>
<c:import url="../layout/footer.jsp" />
</body>
</html>
