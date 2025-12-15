<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<title>Chỉnh sửa email</title>
<jsp:include page="layout-admin.jsp" />

<div class="content" style="padding:25px;">

    <div style="max-width:850px; margin:auto;">

        <h2 style="color:#D93A20; font-size:28px; font-weight:700; 
                   text-align:center; margin-bottom:25px;">
            <c:choose>
                <c:when test="${not empty newsletter}">✏️ Sửa email</c:when>
                <c:otherwise>📝 Thêm email</c:otherwise>
            </c:choose>
        </h2>

        <div style="background:white; padding:30px; border-radius:18px; box-shadow:0 4px 14px rgba(0,0,0,0.12);">

            <form method="post" action="${pageContext.request.contextPath}/admin/newsletter">
                
                <input type="hidden" name="action" value="${not empty newsletter ? 'update' : 'add'}">

                <label style="font-weight:600;">Email</label>
                <input type="email" name="email" value="${newsletter.email}"
                       style="width:100%; padding:12px; margin:8px 0 18px; border:1px solid #ccc; border-radius:10px; ${not empty newsletter ? 'background-color:#eee;' : ''}" 
                       required
                       ${not empty newsletter ? 'readonly' : ''}> 
                       <label style="display:flex; align-items:center; gap:8px; font-weight:600; margin:10px 0;">
                    <input type="checkbox" name="enabled" value="true"
                           <c:if test="${newsletter.enabled}">checked</c:if> >
                    Đăng kí nhận tin (Enabled)
                </label>

                <div style="margin-top:20px;">
                    <button type="submit"
                        style="background:#D93A20; color:white; padding:12px 20px; border:none; border-radius:10px; font-weight:700; cursor:pointer;">
                        Lưu lại
                    </button>

                    <a href="${pageContext.request.contextPath}/admin/newsletter"
                       style="background:#ccc; color:black; padding:12px 20px; border-radius:10px; margin-left:10px; text-decoration:none;">
                        Quay lại
                    </a>
                </div>

            </form>

        </div>
    </div>
</div>