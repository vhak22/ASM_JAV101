<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reporter Dashboard</title>
<jsp:include page="layout-admin.jsp" />

<!-- Dashboard content -->
<div class="card-row">
  <div class="card">
    <h3>Tổng bài viết</h3>
    <p style="font-size:28px; color:var(--brand); margin:8px 0;">${countPost}</p>
    <small>Bài viết trong hệ thống của ${user.fullname}</small>
  </div>

  <div class="card">
    <h3>Tổng số lượt xem</h3>
    <p style="font-size:28px; color:var(--brand); margin:8px 0;">${sumViews}</p>
    <small>Lượt người dùng đã xem</small>
  </div>

  <div class="card">
    <h3>Tổng số lượt xem bài viết mới nhất</h3>
    <p style="font-size:28px; color:var(--brand); margin:8px 0;">${LatestPostViews}</p>
    <small>Lượt xem</small>
  </div>
</div>

<div class="card">
  <h3>10 Bài viết mới nhất của ${user.fullname}</h3>

  <table class="table">
    <thead>
      <tr><th>ID</th><th>Tiêu đề</th><th>Danh mục</th><th>Tác giả</th><th>Lượt xem</th><th>Ngày</th></tr>
    </thead>
    <tbody>
      <c:forEach items="${list}" var="n" begin="0" end="9">
        <tr>
          <td>${n.id}</td>
          <td>${n.title}</td>
          <td>${n.categoryId}</td>
          <td>${n.author}</td>
          <td>${n.viewCount}</td>
          <td>${n.postedDate}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</div>
</body>
</html>
