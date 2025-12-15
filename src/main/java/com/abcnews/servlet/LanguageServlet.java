package com.abcnews.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.jstl.core.Config; // Cần import thư viện JSTL
import java.io.IOException;
import java.util.Locale;

@WebServlet("/language")
public class LanguageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String lang = req.getParameter("lang");
        
        // Tạo Locale dựa trên tham số truyền vào
        Locale locale;
        if ("en".equals(lang)) {
            locale = new Locale("en", "US");
        } else {
            locale = new Locale("vi", "VN");
        }

        HttpSession session = req.getSession();
        // Cấu hình Locale cho JSTL fmt
        Config.set(session, Config.FMT_LOCALE, locale);
        
        // Lưu attribute để hiển thị active trên giao diện (nếu cần)
        session.setAttribute("lang", lang);

        // Quay lại trang trước đó
        String referer = req.getHeader("referer");
        resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/home");
    }
}