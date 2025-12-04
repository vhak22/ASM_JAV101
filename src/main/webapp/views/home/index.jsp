<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lều Báo - Trang chủ</title>
    <!-- Sử dụng Tailwind CSS để dễ dàng tạo bố cục responsive và đẹp mắt -->
    <script src="https://cdn.tailwindcss.com"></script>
 <!--   <link rel="stylesheet" href="${pageContext.request.contextPath}/views/style/styleAll.css"> -->
 <style>
        body {
            margin: 0;
            padding: 0;
            background: #FFF6F2;
            font-family: 'Inter', sans-serif;
        }

        /* MAIN CONTAINER */
        .container {
            max-width: 1200px;
            margin: 30px auto;
            display: flex;
            gap: 30px;
        }

        /* LEFT CONTENT */
        .left {
            flex: 3;
        }

        /* SECTION BOXES */
        .box {
            background: #FFF1EB;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
        }

        .box h1 {
            color: #D93A20;
            margin-top: 0;
            font-size: 22px;
    		font-weight: bold;
        }

        /* TIN CHI TIẾT GIẢ */
        .detail-box {
            background: #FFF1EB;
            padding: 20px;
            border-radius: 14px;
           
            max-height: 551px;
            overflow-y: auto;
        }

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

        /* SIDEBAR */
        .sidebar {
            flex: 1.2;
        }
        /* LIST WRAPPER */
		.post-list {
		
		    max-height: 447px;      /* Giới hạn chiều cao */
		    overflow-y: auto;       /* Hiển thị thanh cuộn dọc */
		    padding-right: 10px;
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
		.box h3 { 
			color: #D93A20; 
			margin-top: 0;             
			font-size: 22px;
    		font-weight: bold;
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
	
	<!-- MAIN -->
    <div class="container">

        <!-- LEFT -->
        <div class="left">

            <!-- TIN NỔI BẬT -->
            <div class="box">
                <h1>📰 Tin nổi bật</h1>
				<c:import url="../home/news-list.jsp" />
            </div>

            <!-- BÀI VIẾT DEMO -->

   <!--          <div class="detail-box">
                <c:forEach var="item" items="${latestNews}">
                <div class="detail-box">
                    <h2 style="color:#D93A20;">${item.title}</h2>
                    <p style="color:#555; font-size:14px;">Ngày đăng: ${item.postedDate}</p>

                    <div style="display:flex; gap:20px; margin-top:20px;">
                        <div style="flex:1;">
                            <img src="${item.image}" style="
                                width:100%; height:180px; object-fit:cover;
                                border-radius:10px; background:#F5F5F5;">
                        </div>

                        <div style="flex:2;">
                            <p style="font-size:15px; line-height:1.6;">
                                ${item.content}
                            </p>
                        </div>
                    </div>
                </div>
            </c:forEach>
            </div>-->

        </div>

        <!-- RIGHT SIDEBAR -->
        <div class="sidebar">
        	<div class="box">
                <h3>🆕 Tin mới nhất</h3>
                <p class= "top5"><c:import url="/views/home/top5view.jsp" /></p>
            </div>

            <div class="box">
                <h3>🔥 Tin xem nhiều</h3>
                <p class= "top5"><c:import url="/views/home/top5view.jsp" /></p>
            </div>

            <!-- NEWSLETTER -->
            <div class="newsletter">
                <h3>Đăng ký nhận bản tin</h3>

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