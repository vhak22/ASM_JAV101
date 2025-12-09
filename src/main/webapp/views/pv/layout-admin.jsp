<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- layout-admin.jsp -->
<style>
  /* global */
  :root{
    --brand:#D93A20;
    --accent:#FF6A3D;
    --bg:#FFF6F2;
    --card:#fff;
    --sidebar:#FCD4C6;
  }
  body { margin:0; font-family: Inter, Arial, sans-serif; background:var(--bg); color:#222; }
  .admin-shell { display:flex; min-height:100vh; }
  /* sidebar */
  .admin-sidebar {
    width:265px; background:var(--sidebar); padding:22px; box-sizing:border-box;
    border-right: 1px solid rgba(0,0,0,0.04);
  }
  .brand { font-size:20px; font-weight:700; color:var(--brand); margin-bottom:10px; }
  .sidebar-menu { margin-top:18px; }
  .sidebar-menu a { display:block; padding:10px 12px; margin-bottom:8px; color:#4b2a20; text-decoration:none; border-radius:8px; }
  .sidebar-menu a:hover { background: rgba(217,58,32,0.08); color:var(--brand); }
  .sidebar-menu .logout { margin-top:18px; color:#fff; background:var(--accent); display:inline-block; padding:8px 12px; border-radius:8px; text-decoration:none; }
  /* main */
  .admin-main { flex:1; padding:20px 28px; box-sizing:border-box; }
  .admin-top { display:flex; justify-content:space-between; align-items:center; margin-bottom:18px; }
  .admin-top h1 { margin:0; color:var(--brand); font-size:22px; }
  .card-row { display:flex; gap:18px; margin-bottom:18px; flex-wrap:wrap; }
  .card { background:var(--card); padding:16px; border-radius:12px; box-shadow:0 6px 18px rgba(0,0,0,0.06); flex:1; min-width:180px; }
  .table { width:100%; border-collapse:collapse; background:var(--card); border-radius:8px; overflow:hidden; box-shadow:0 4px 12px rgba(0,0,0,0.04); }
  .table th, .table td { padding:10px 12px; border-bottom:1px solid #eee; text-align:left; font-size:14px; }
  .table th { background:#fff; color:#333; }
  .btn { display:inline-block; padding:8px 10px; border-radius:8px; text-decoration:none; font-weight:600; }
  .btn-primary { background:var(--brand); color:#fff; }
  .btn-danger { background:#d9534f; color:#fff; }
  .form-inline input, .form-inline select { padding:8px; border-radius:8px; border:1px solid #ddd; }
  .form-inline .btn { vertical-align:middle; }
  @media (max-width:900px){
    .admin-shell { flex-direction:column; }
    .admin-sidebar { width:100%; display:flex; gap:10px; overflow:auto; }
    .admin-main { padding:12px; }
  }
</style>

<div class="admin-shell">
  <div class="admin-sidebar">
    <div class="brand">ABC News — Reporter</div>
    <div class="small">Quản trị Phóng Viên</div>

    <div class="sidebar-menu">
      <a href="${pageContext.request.contextPath}/reporter/dashboard">Dashboard</a>
      <a href="${pageContext.request.contextPath}/reporter/news">Quản lý tin tức</a>
      <a href="${pageContext.request.contextPath}/reporter/user">Chỉnh sửa thông tin</a>
       <a href="${pageContext.request.contextPath}/home">Trang chủ</a>
      <a class="logout" href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
    </div>
  </div>

  <div class="admin-main">
    <div class="admin-top">
      <h1>Reporter Panel</h1>
      <div>Xin chào, <strong>${user.fullname}</strong></div>
    </div>

    <!-- content of each page goes here -->
