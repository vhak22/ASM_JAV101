<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${news.title}</title>

    <style>
        body { font-family: Arial; background:#FFF6F2; margin:0; }
        header { background:#D93A20; padding:15px; color:white; }
        .detail-container { width:900px; margin:auto; padding:20px; }

        .title { color:#D93A20; font-size:28px; }
        .news-img { width:100%; border-radius:12px; margin:20px 0; }
        p.content { font-size:17px; line-height:1.6; }

    </style>
</head>

<body>

 <c:import url="../layout/header.jsp" />

<div class="detail-container">

    <h1 class="title">${news.title}</h1>
    <p><i>${news.postedDate}</i></p>

    <img class="news-img" src="${news.image}">

    <p class="content">${news.content}</p>

    <hr>

    <h3>Tin tức cùng loại</h3>
    <ul>
        <c:forEach var="n" items="${relatedNews}">
            <li><a href="detail?id=${n.id}">${n.title}</a></li>
        </c:forEach>
    </ul>

</div>

</body>
</html>
