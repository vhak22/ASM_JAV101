<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<title>Reporter - ${title}</title>
<jsp:include page="layout-admin.jsp" />

<div class="content" style="padding:25px;">

    <div style="max-width:850px; margin:auto;">

        <!-- HEADER -->
        <h2 style="color:#D93A20; font-size:28px; font-weight:700; 
                   text-align:center; margin-bottom:25px;">
            <c:choose>
                <c:when test="${not empty news}">✏️ Sửa bài viết</c:when>
                <c:otherwise>📝 Thêm bài viết</c:otherwise>
            </c:choose>
        </h2>

        <!-- CARD FORM -->
        <div style="
            background:white;
            padding:30px;
            border-radius:18px;
            box-shadow:0 4px 14px rgba(0,0,0,0.12);
        ">

            <form method="post" action="${pageContext.request.contextPath}/reporter/news">

                <!-- ID (readonly khi edit) -->
                <label style="font-weight:600;">Tiêu đề</label>
                <input type="text" name="title" value="${news.title}"
                       style="width:100%; padding:12px; margin:8px 0 18px;
                              border:1px solid #ccc; border-radius:10px;" required>

                <label style="font-weight:600;">Ảnh (URL)</label>
                <input type="text" name="image" value="${news.image}"
                       style="width:100%; padding:12px; margin:8px 0 18px;
                              border:1px solid #ccc; border-radius:10px;" required>

                <label style="font-weight:600;">Danh mục</label>
                <select name="categoryId" required>
				    <c:forEach var="c" items="${aws}">
				        <option value="${c.id}">
				            ${c.name}
				        </option>
				    </c:forEach>
				</select>
				<br><br>


                <label style="font-weight:600;">Ngày đăng</label>
                <input type="date" name="createdAt"
                       value="${news.postedDate}"
                       style="width:100%; padding:12px; margin:8px 0 18px;
                              border:1px solid #ccc; border-radius:10px;">


                <label style="font-weight:600;">Nội dung</label>
                <textarea name="content" rows="8"
                          style="width:100%; padding:12px; margin:8px 0 25px;
                                 border:1px solid #ccc; border-radius:10px;">${news.content}</textarea>

                <!-- BUTTONS -->
                <div style="margin-top:10px;">
                    <button type="submit"
                        style="background:#D93A20; color:white; padding:12px 20px;
                               border:none; border-radius:10px; font-weight:700;">
                        Lưu
                    </button>

                    <a href="${pageContext.request.contextPath}/reporter/news"
                       style="background:#ccc; color:black; padding:12px 20px;
                              border-radius:10px; margin-left:10px; text-decoration:none;">
                        Quay lại
                    </a>
                </div>

                <!-- Hidden field: action -->
                <input type="hidden" name="view" value="${news.viewCount}">
                <input type="hidden" name="highlight" value="${news.home}">
                <input type="hidden" name="action" value="${param.action}">
                <input type="hidden" name="id" value="${news.id}">
            </form>

        </div>
    </div>
</div>
