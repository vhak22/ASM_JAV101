package com.abcnews.servlet.admin;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.abcnews.dao.NewsletterDAO;
import com.abcnews.daoimpl.NewsletterDAOImpl;
import com.abcnews.entity.Newsletter;

@WebServlet("/admin/newsletter")
public class AdminNewsLetters extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Khởi tạo DAO
    private NewsletterDAO newsletterDAO = new NewsletterDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        // 1. Chức năng Xóa
        if ("delete".equals(action)) {
            String email = req.getParameter("email");
            if (email != null) {
                newsletterDAO.delete(email);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/newsletter");
            return;
        }

        // 2. Chức năng Sửa (Load dữ liệu lên form)
        if ("edit".equals(action)) {
            String email = req.getParameter("email");
            // SỬA LỖI Ở ĐÂY: Phải tìm đối tượng (findById), không dùng exists
            Newsletter item = newsletterDAO.findById(email);
            req.setAttribute("newsletter", item);
            req.getRequestDispatcher("/views/admin/newsletter-form.jsp").forward(req, resp);
            return;
        }

        // 3. Chức năng Thêm mới (Chuyển sang form trống)
        if ("add".equals(action)) {
            req.getRequestDispatcher("/views/admin/newsletter-form.jsp").forward(req, resp);
            return;
        }

        // 4. Mặc định: Hiển thị danh sách
        req.setAttribute("list", newsletterDAO.findAll());
        req.getRequestDispatcher("/views/admin/newsletter.jsp").forward(req, resp);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        try {
            // Lấy dữ liệu từ form
            String email = req.getParameter("email");
            boolean enabled = req.getParameter("enabled") != null; // Checkbox: nếu tick là on, ko tick là null
            String action = req.getParameter("action"); // Lấy action từ thẻ input hidden

            Newsletter n = new Newsletter();
            n.setEmail(email);
            n.setEnabled(enabled);

            // SỬA LỖI LOGIC INSERT/UPDATE
            if ("update".equals(action)) {
                newsletterDAO.update(n);
            } else {
                // Mặc định là thêm mới (add)
                // Kiểm tra email không được rỗng trước khi insert
                if(email != null && !email.trim().isEmpty()){
                    newsletterDAO.insert(n);
                }
            }

            resp.sendRedirect(req.getContextPath() + "/admin/newsletter");
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi Database: " + e.getMessage());
        }
    }
}