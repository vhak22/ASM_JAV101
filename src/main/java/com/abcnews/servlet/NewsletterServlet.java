package com.abcnews.servlet;

import com.abcnews.dao.NewsletterDAO;
import com.abcnews.daoimpl.NewsletterDAOImpl;
import com.abcnews.entity.Newsletter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/newsletter")
public class NewsletterServlet extends HttpServlet {

    private NewsletterDAO newsletterDAO = new NewsletterDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String email = req.getParameter("email");
        String redirectUrl = req.getContextPath() + "/home"; // URL mặc định

        try {
            // 1. KIỂM TRA TỒN TẠI TRƯỚC KHI THÊM
            if (newsletterDAO.exists(email)) {
                // Email đã tồn tại
                // Chuyển hướng với thông báo lỗi (ví dụ: subscribed=2)
                resp.sendRedirect(redirectUrl + "?subscribed=2&email=" + email);
            } else {
                // Email chưa tồn tại -> Thực hiện insert
                Newsletter n = new Newsletter();
                n.setEmail(email);
                n.setEnabled(true);

                newsletterDAO.insert(n);

                // Chuyển hướng với thông báo thành công (ví dụ: subscribed=1)
                resp.sendRedirect(redirectUrl + "?subscribed=1");
            }
        } catch (Exception e) {
            // Ghi log lỗi để debug
            e.printStackTrace();
            
            // Xử lý các lỗi Runtime hoặc SQLException không mong muốn (ngoại trừ PK violation đã xử lý)
            // Chuyển hướng với thông báo lỗi chung (ví dụ: subscribed=3)
            resp.sendRedirect(redirectUrl + "?subscribed=3");
        }
    }
}