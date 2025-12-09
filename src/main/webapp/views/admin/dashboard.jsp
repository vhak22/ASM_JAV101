<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard</title>
<jsp:include page="layout-admin.jsp" />

<!-- Dashboard content -->
<div class="card-row">
  <div class="card">
    <h3>Tổng bài viết</h3>
    <p style="font-size:28px; color:var(--brand); margin:8px 0;">${newsCount}</p>
    <small>Bài viết trong hệ thống</small>
  </div>

  <div class="card">
    <h3>Tổng người dùng</h3>
    <p style="font-size:28px; color:var(--brand); margin:8px 0;">${userCount}</p>
    <small>Người dùng đã đăng ký</small>
  </div>

  <div class="card">
    <h3>Tổng danh mục</h3>
    <p style="font-size:28px; color:var(--brand); margin:8px 0;">${categoryCount}</p>
    <small>Danh mục hiện có</small>
  </div>
</div>

<div class="card">
  <h3>10 Bài viết mới nhất</h3>

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
