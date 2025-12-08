<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Thêm / Sửa người dùng</title>

<style>
body {
    font-family: Arial, sans-serif;
    background: #FFF6F2;
}
.form-box {
    max-width: 520px;
    margin: 40px auto;
    background: white;
    padding: 30px;
    border-radius: 14px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.12);
}
.form-title {
    font-size: 24px;
    font-weight: 700;
    color: #D93A20;
    margin-bottom: 20px;
    text-align: center;
}
input, select {
    width: 100%;
    padding: 10px;
    border-radius: 10px;
    border: 1px solid #ccc;
    margin-bottom: 15px;
    font-size: 15px;
}
.gender-box {
    display: flex;
    gap: 25px;
    margin-bottom: 12px;
}
.gender-box label {
    display: flex;
    align-items: center;
    gap: 6px;
    font-size: 14px;
}
.btn-save {
    width: 100%;
    background: #D93A20;
    padding: 12px;
    color: white;
    border-radius: 10px;
    border: none;
    font-size: 17px;
    font-weight: 700;
    cursor: pointer;
}
.btn-back {
    display: block;
    margin-top: 12px;
    text-align: center;
    color: #555;
    text-decoration: none;
}
</style>
</head>

<body>
	<jsp:include page="layout-admin.jsp" />
	
<div class="form-box">

    <div class="form-title">
    	✏️ Sửa người dùng
    </div>

    <form method="post" action="${pageContext.request.contextPath}/reporter/user">
        <input type="hidden" name="action" value="${empty add ? 'add' : 'update'}">
		
        <!-- ID -->
        <label>ID</label>
        <input type="text" name="id" value="${user.id}" ${empty add ? "" : "readonly"} required>

        <!-- Fullname -->
        <label>Họ và tên</label>
        <input type="text" name="fullname" value="${user.fullname}" required>

        <!-- Birthday -->
        <label>Ngày sinh</label>
        <input type="date" name="birthday" value="${user.birthday}" required>

        <!-- Gender -->
        <label>Giới tính</label>
        <div class="gender-box">
            <label>
                <input type="radio" name="gender" value="true" ${user.gender ? "checked" : ""}> Nam
            </label>
            <label>
                <input type="radio" name="gender" value="false" ${!user.gender ? "checked" : ""}> Nữ
            </label>
        </div>

        <!-- Mobile -->
        <label>Điện thoại</label>
        <input type="text" name="mobile" value="${user.mobile}" required>

        <!-- Email -->
        <label>Email</label>
        <input type="email" name="email" value="${user.email}" required>

        <!-- Password -->
        <label>Mật khẩu</label>
        <input type="password" name="password" value="${user.password}" required>

        <!-- Role -->
        <label>Vai trò</label>
        <select name="role">
            <option value="false" ${!user.role ? "selected" : ""}>Reporter</option>
        </select>
		
		 <label>Thông báo</label>
        <input type="text"  value="${error}" readonly>
        
        <button class="btn-save" type="submit">Lưu</button>
        <a class="btn-back" href="${pageContext.request.contextPath}/reporter/user">⬅ Quay lại</a>
    </form>

</div>

</body>
</html>
