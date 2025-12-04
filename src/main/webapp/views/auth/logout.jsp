<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký – ABC News</title>
    <%
    session.invalidate();
    response.sendRedirect(request.getContextPath() + "/home");
	%>

</body>
</html>
