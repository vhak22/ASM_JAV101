<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="layout-admin.jsp" />
<title>Đăng kí bản tin</title>
<style>
    .admin-container {
        padding: 20px;
        background-color:#FFF6F2;
        min-height: 100vh;
    }
    .header-box {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 20px;
    }
    .header-box h2 {
        color: #D93A20;
        font-weight: 700;
        font-size: 24px;
        margin: 0;
    }
    .btn-add {
        background: #D93A20;
        color: white;
        padding: 10px 16px;
        border-radius: 8px;
        text-decoration: none;
        font-size: 14px;
        font-weight: 600;
        transition: 0.3s;
    }
    .btn-add:hover {
        background: #FF6A3D;
    }
    .table-card {
        background: white;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        padding: 0;
    }
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        padding: 14px 15px;
        border-bottom: 1px solid #f0f0f0;
        font-size: 14px;
        vertical-align: middle;
    }
    th {
        background: #D93A20;
        color: white;
        font-weight: 600;
        text-align: left;
    }

    .btn {
        padding: 6px 12px;
        border-radius: 6px;
        text-decoration: none;
        font-size: 13px;
        display: inline-block;
        font-weight: 500;
    }
    .btn-edit {
        background: #FF6A3D;
        color: white;
        margin-right: 5px;
    }

    .btn-delete {
        background: #D93A20;
        color: white;
    }

    /* Badge trạng thái */
    .status-active { color: #28a745; font-weight: bold; }
    .status-inactive { color: #ccc; font-weight: bold; }
</style>

<div class="admin-container">

    <div class="header-box">
        <h2>Quản lý bản tin</h2>
        <a class="btn-add" href="${pageContext.request.contextPath}/admin/newsletter?action=add">
            + Thêm Email
        </a>
    </div>

    <div class="table-card">
        <table>
            <thead>
                <tr>
                    <th>Email</th>
                    <th>Trạng thái</th>
                    <th style="width: 150px;">Hành động</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="n" items="${list}">
                    <tr>
                        <td>${n.email}</td>

                        <td>
                            <c:choose>
                                <c:when test="${n.enabled}">
                                    <span class="status-active">✔ Đang hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-inactive">✖ Ngừng nhận tin</span>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <a href="${pageContext.request.contextPath}/admin/newsletter?action=edit&email=${n.email}" 
                               class="btn btn-edit">Sửa</a>

                            <a href="${pageContext.request.contextPath}/admin/newsletter?action=delete&email=${n.email}"
                               onclick="return confirm('Bạn có chắc muốn xóa email này?')"
                               class="btn btn-delete">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</div>