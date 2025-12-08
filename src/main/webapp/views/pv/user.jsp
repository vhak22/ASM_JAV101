<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="layout-admin.jsp" />

<style>
    .user-container {
        padding: 20px;
        display: flex;
        gap: 20px;
    }
    .user-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 12px;
    }
    .user-header h2 {
        color: #D93A20;
        font-weight: 700;
        font-size: 24px;
    }
    .btn-add {
        background: #D93A20;
        color: white;
        padding: 8px 14px;
        border-radius: 6px;
        text-decoration: none;
        font-size: 14px;
    }
    .btn-add:hover {
        background: #FF6A3D;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 4px 10px rgba(0,0,0,0.06);
    }
    th, td {
        padding: 12px;
        border-bottom: 1px solid #f0f0f0;
        font-size: 14px;
    }
    th {
        background: #D93A20;
        color: white;
        font-weight: 600;
        text-align: left;
    }
    .btn {
        padding: 6px 10px;
        border-radius: 6px;
        text-decoration: none;
        font-size: 13px;
    }
    .btn-edit {
        background: #FF6A3D;
        color: white;
    }
    .btn-edit:hover {
        background: #ff865e;
    }
    .btn-delete {
        background: #D93A20;
        color: white;
    }
    .btn-delete:hover {
        background: #b72f1a;
    }
</style>

<div class="user-container">

  <div style="flex:1;">

    <div class="user-header">
      <h2>Thông Tin Phóng Viên</h2>
    </div>

    <table>
      <thead>
        <tr>
          <th>ID</th>
          <th>Họ tên</th>
          <th>Ngày sinh</th>
          <th>Giới tính</th>
          <th>Điện thoại</th>
          <th>Email</th>
          <th>Vai trò</th>
          <th style="width:130px;">Hành động</th>
        </tr>
      </thead>

      <tbody>
          <tr>
            <td readonly>${user.id}</td>
            <td>${user.fullname}</td>
            <td>${user.birthday}</td>

            <td>
              <c:if test="${user.gender == true}">Nam</c:if>
              <c:if test="${user.gender == false}">Nữ</c:if>
            </td>

            <td>${user.mobile}</td>
            <td>${user.email}</td>

            <td>
              <c:if test="${user.role == true}">Admin</c:if>
              <c:if test="${user.role == false}">Reporter</c:if>
            </td>

            <td>
              <a class="btn btn-edit" href="${pageContext.request.contextPath}/reporter/user/edit?id=${user.id}">Sửa</a>
            </td>
          </tr>
      </tbody>
    </table>

  </div>

</div>
