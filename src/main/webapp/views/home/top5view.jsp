<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:if test="${not empty top5view}">
	<c:forEach var="n" items="${top5view}"> 				
		<a href="${pageContext.request.contextPath}/detail?id=${n.id}"  class="top5title">
			<p>${n.title}</p>
		</a>
	</c:forEach>
</c:if>

<c:if test="${empty top5view}">
	<p>Không tìm thấy bài viết.</p>
</c:if>
