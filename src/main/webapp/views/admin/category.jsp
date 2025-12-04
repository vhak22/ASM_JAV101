<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="layout-admin.jsp" />

<div class="content" style="padding:25px;">

    <div class="header" 
         style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
        <h2 style="font-size:26px; color:#D93A20; font-weight:700;">Quản lý danh mục</h2>

        <a class="btn-add"
           href="${pageContext.request.contextPath}/views/admin/category-form.jsp?action=add"
           style="background:#D93A20; padding:10px 16px; color:white; font-weight:600;
                  border-radius:10px; text-decoration:none;">
            + Thêm mới
        </a>
    </div>

    <div style="background:white; border-radius:14px; padding:20px;
                box-shadow:0 4px 12px rgba(0,0,0,0.12);">

        <table style="width:100%; border-collapse:collapse;">
            <thead style="background:#FFE3DB;">
                <tr>
                    <th style="padding:12px;">ID</th>
                    <th style="padding:12px;">Tên danh mục</th>
                    <th style="padding:12px;">Hành động</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="c" items="${list}">
                    <tr>
                        <td style="padding:10px;">${c.id}</td>
                        <td style="padding:10px;">${c.name}</td>

                        <td style="padding:10px;">
                            <a href="${pageContext.request.contextPath}/views/admin/category-form.jsp?action=edit&id=${c.id}"
                               style="background:#FF6A3D; color:white; padding:6px 12px; 
                                      border-radius:6px; text-decoration:none;">
                                Sửa
                            </a>

                            <a href="${pageContext.request.contextPath}/admin/category?action=delete&id=${c.id}"
                               onclick="return confirm('Xóa danh mục này?')"
                               style="background:#D93A20; color:white; padding:6px 12px;
                                      border-radius:6px; text-decoration:none; margin-left:5px;">
                                Xóa
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>

        </table>
    </div>

</div>
</div>
