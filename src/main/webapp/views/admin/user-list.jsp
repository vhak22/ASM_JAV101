<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="layout-admin.jsp" />

<div class="container" style="padding:30px;">

    <div class="header" 
         style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
        <h2 style="font-size:28px; color:#D93A20; font-weight:700;">Quản lý người dùng</h2>

        <a class="btn-add" href="${pageContext.request.contextPath}/admin/user/add" style="background:#D93A20; color:white; padding:10px 18px; text-decoration:none;
                  border-radius:10px; font-size:15px; font-weight:600;">+ Thêm mới</a>
    </div>

    <div class="table-box"
         style="background:white; border-radius:14px; padding:20px; 
                box-shadow:0 4px 12px rgba(0,0,0,0.12);">

        <table style="width:100%; border-collapse:collapse;">
            <thead style="background:#FFE3DB;">
                <tr>
                    <th style="padding:12px;">ID</th>
                    <th style="padding:12px;">Họ tên</th>
                    <th style="padding:12px;">Email</th>
                    <th style="padding:12px;">Điện thoại</th>
                    <th style="padding:12px;">Vai trò</th>
                    <th style="padding:12px;">Hành động</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="u" items="${users}">
                    <tr>
                        <td style="padding:10px;">${u.id}</td>
                        <td style="padding:10px;">${u.fullname}</td>
                        <td style="padding:10px;">${u.email}</td>
                        <td style="padding:10px;">${u.mobile}</td>

                        <td style="padding:10px;">
                            <c:choose>
        <c:when test="${u.role}">Admin</c:when>
        <c:otherwise>Reporter</c:otherwise>
    </c:choose>
                        </td>

                        <td style="padding:10px;">
                            <a class="action-btn btn-edit" href="${pageContext.request.contextPath}/admin/user/edit?id=${u.id}" style="background:#FF6A3D; color:white; padding:6px 12px; border-radius:6px; 
                                      text-decoration:none; margin-right:5px;">Sửa</a>
                            

                            <a href="${pageContext.request.contextPath}/admin/user?action=delete&id=${u.id}"
                               onclick="return confirm('Xóa người dùng này?')"
                               style="background:#D93A20; color:white; padding:6px 12px; border-radius:6px; 
                                      text-decoration:none;">
                                Xóa
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>

        </table>
    </div>

</div>
