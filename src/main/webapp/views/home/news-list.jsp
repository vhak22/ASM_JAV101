<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<div class="detail-box">
    <!-- CHI TIẾT BÀI VIẾT -->
    <c:if test="${not empty list}">
	    <c:forEach var="n" items="${list}">
	    	<c:if test="${n.home}">    	
		        <div class="post-box">
		            <a href="${pageContext.request.contextPath}/detail?id=${n.id}">
                    	<img class="post-img" src="${n.image}" alt="Ảnh bài viết"/>
                	</a>
		
		            <div class="post-info">
			            <a href="${pageContext.request.contextPath}/detail?id=${n.id}">
			            	<h2 class="post-title">${n.title}</h2>
			            </a>
		                <p class="postedDate">Ngày đăng: ${n.postedDate} - Tác giả: ${n.author}</p>
		                <p class="post-desc">
						    <c:choose>						     
						        <c:when test="${fn:length(n.content) > 200}">					
						            ${fn:substring(n.content, 0, 200)}...
						        </c:when>
						        <c:otherwise>						   
						            ${n.content}
						        </c:otherwise>
						    </c:choose>
						</p>
		            </div>
		        </div>
		        <br>
	        </c:if>
        </c:forEach>
    </c:if>
	
    <c:if test="${empty list}">
        <p>Không tìm thấy bài viết.</p>
    </c:if>
</div>
