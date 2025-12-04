<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách tin tức - ${category.name}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        /* Sao chép style từ index.jsp để đồng bộ layout */
        body { margin: 0; padding: 0; background: #FFF6F2; font-family: 'Inter', sans-serif; }
        .container { max-width: 1200px; margin: 30px auto; display: flex; gap: 30px; }
        .left { flex: 3; }
        .box { background: #FFF1EB; padding: 20px; border-radius: 12px; margin-bottom: 25px;}
            .box1{max-height: 426px; overflow-y: auto;}
        .box h3 { color: #D93A20; margin-top: 0;             font-size: 22px;
    		font-weight: bold;}
		.detail-box {
            background: #FFF1EB;
            padding: 20px;
            border-radius: 14px;
           
            max-height: 551px;
            overflow-y: auto;
        }        .sidebar { flex: 1.2; }
         /* NEWSLETTER */
        .newsletter {
            background: #FFE6DE;
            padding: 30px;
            border-radius: 14px;
            margin-bottom: 30px;
        }
        .newsletter input {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 15px;
        }
        .newsletter button {
            margin-top: 12px;
            padding: 10px 25px;
            background: #D93A20;
            color: #fff;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 15px;
        }
        /* CARD BÀI VIẾT */
		.post-box {
		    background: #FFFFFF;
		    display: flex;
		    gap: 20px;
		    padding: 18px;
		    border-radius: 14px;
		    box-shadow: 0 0 8px rgba(0,0,0,0.08);
		    transition: 0.2s;
		}
		
		.post-box:hover {
		    transform: translateY(-3px);
		    box-shadow: 0 4px 12px rgba(0,0,0,0.12);
		}
		
		/* ẢNH */
		.post-img {
		    width: 180px;
		    height: 130px;
		    object-fit: cover;
		    border-radius: 12px;
		    background: #F5F5F5;
		}
		
		/* THÔNG TIN */
		.post-info {
		    flex: 1;
		}
		
		.post-title {
		    color: #D93A20;
		    margin: 0;
		    font-size: 22px;
		    font-weight: bold;
		}
		
		.post-date {
		    color: #666;
		    font-size: 14px;
		    margin: 4px 0 10px 0;
		}
		
		.post-desc {
		    font-size: 15px;
		    color: #444;
		    line-height: 1.5;
		}
		.top5title {
		    /* Mặc định: Loại bỏ gạch chân (tuỳ chọn) */
		    color: #D93A20;
		    text-decoration: none; 
		}
		
		.top5title:hover {
		    /* Khi di chuột vào (hover): Thêm gạch chân */
		    text-decoration: underline; 
		     
		}
		.newsletter h3{
			color: #D93A20; 
			margin-top: 0;             
			font-size: 22px;
    		font-weight: bold;
		}
    </style>
</head>
<body>

    <c:import url="../layout/header.jsp" />
	
	<div class="container">

        <div class="left">

            <div class="box">
                <h3>📰 Tin tức: ${category.name}</h3>
          
                <c:import url="../category/category.jsp" />
              <!--  <div class="box1">
                <c:if test="${not empty newsList}">
                    <c:forEach var="item" items="${newsList}" varStatus="loop">
                        <div class="detail-box ${loop.index > 0 ? 'mt-4' : ''}">
                            <a href="${pageContext.request.contextPath}/news/detail?id=${item.id}" style="text-decoration:none;">
                                <h2 style="color:#D93A20; font-size:20px; margin-bottom: 5px;">${item.title}</h2>
                            </a>
                            <p style="color:#777; font-size:13px; margin-top:0;">Ngày đăng: ${item.postedDate} - Tác giả: ${item.author}</p>

                            <div style="display:flex; gap:20px; margin-top:10px;">
                                <div style="flex:1;">
                                    <a href="${pageContext.request.contextPath}/news/detail?id=${item.id}">
                                        <img src="${item.image}" alt="${item.title}" style="
                                            width:100%; height:120px; object-fit:cover;
                                            border-radius:10px; background:#F5F5F5;">
                                    </a>
                                </div>

                                <div style="flex:2;">
                                    <p style="font-size:15px; line-height:1.6; color:#333;">
                                        ${item.content.length() > 150 ? item.content.substring(0, 150).concat('...') : item.content}
                                    </p>
                                </div>
                            </div>
                        </div>
                        <c:if test="${!loop.last}">
                            <hr style="border: 0; border-top: 1px dashed #DDD; margin: 15px 0;" />
                        </c:if>
                    </c:forEach>
                </c:if>
                <c:if test="${empty newsList}">
                    <p>(Không tìm thấy bản tin nào trong danh mục này.)</p>
                </c:if>
                </div>-->
            </div>
            
            </div>

        <div class="sidebar">
        	<div class="box">
                <h3>🆕 Tin mới nhất</h3>
                 <p class= "top5"><c:import url="/views/home/top5view.jsp" /></p>
            </div>

            <div class="box">
                <h3>🔥 Tin xem nhiều</h3>
                 <p class= "top5"><c:import url="/views/home/top5view.jsp" /></p>
            </div>

            <div class="newsletter">
                <h3 >
			    		Đăng ký nhận bản tin
	    		</h3>

                <form action="${pageContext.request.contextPath}/newsletter" method="post">
                    <input type="email" name="email" placeholder="Nhập email..." required>
                    <button type="submit">Đăng ký</button>
                </form>

                <c:if test="${not empty msg}">
                    <p style="color:green; margin-top:10px;">${msg}</p>
                </c:if>
            </div>

        </div>

    </div>
	

</body>
<c:import url="../layout/footer.jsp" />
</html>