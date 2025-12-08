<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="layout-admin.jsp" />

<div class="content" style="padding:25px;">

    <!-- HEADER + BUTTON -->
    <div class="header"
         style="display:flex; justify-content:space-between; align-items:center; margin-bottom:20px;">
        <h2 style="font-size:26px; color:#D93A20; font-weight:700;">Quản lý bài viết</h2>

        <a class="btn-add"
           href="${pageContext.request.contextPath}/reporter/news?action=add"
           style="background:#D93A20; padding:10px 16px; color:white; font-weight:600;
                  border-radius:10px; text-decoration:none;">
            + Thêm mới
        </a>
    </div>

    <!-- TABLE WRAPPER -->
    <div style="background:white; border-radius:14px; padding:20px;
                box-shadow:0 4px 12px rgba(0,0,0,0.12);">

        <table style="width:100%; border-collapse:collapse;">
            <thead style="background:#FFE3DB;">
                <tr>
                    <th style="padding:12px;">ID</th>
                    <th style="padding:12px;">Tiêu đề</th>
                    <th style="padding:12px;">Ảnh</th>
                    <th style="padding:12px;">Danh mục</th>
                    <th style="padding:12px;">Tác giả</th>
                    <th style="padding:12px;">Ngày đăng</th>
                    <th style="padding:12px;">Home</th>
                    <th style="padding:12px;">Hành động</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="n" items="${myNews}">
                    <tr>

                        <td style="padding:10px;">${n.id}</td>

                        <td style="padding:10px; max-width:250px;">
                            ${n.title}
                        </td>

                        <td style="padding:10px;">
                            <img src="${n.image}" style="width:85px; height:55px; object-fit:cover; border-radius:6px;">
                        </td>

                        <td style="padding:10px;">${n.categoryId}</td>
                        <td style="padding:10px;">${n.author}</td>
                        <td style="padding:10px;">${n.postedDate}</td>

                        <td style="padding:10px;">
                            <c:choose>
                                <c:when test="${n.home}">✔</c:when>
                                <c:otherwise>✖</c:otherwise>
                            </c:choose>
                        </td>

                        <td style="padding:10px;">
                            <a href="${pageContext.request.contextPath}/reporter/news?action=edit&id=${n.id}"
                               style="background:#FF6A3D; color:white; padding:6px 12px;
                                      border-radius:6px; text-decoration:none;">
                                Sửa
                            </a>

                            <a href="${pageContext.request.contextPath}/reporter/news?action=delete&id=${n.id}"
                               onclick="return confirm('Xóa bài viết này?')"
                               style="background:#D93A20; color:white; padding:6px 12px;
                                      border-radius:6px; margin-left:5px; text-decoration:none;">
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
