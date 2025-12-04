package com.abcnews.servlet.admin;

import com.abcnews.dao.UserDAO;
import com.abcnews.daoimpl.UserDAOImpl;
import com.abcnews.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet({"/admin/user", "/admin/user/add", "/admin/user/edit", "/admin/user/delete"})
public class AdminUserServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String uri = req.getRequestURI();

        // -------------------------------------
        // 1. TRANG DANH SÁCH NGƯỜI DÙNG
        // -------------------------------------
        if (uri.endsWith("/user")) {
            req.setAttribute("list", userDAO.findAll());
            req.getRequestDispatcher("/views/admin/user.jsp").forward(req, resp);
            return;
        }

        // -------------------------------------
        // 2. TRANG THÊM NGƯỜI DÙNG
        // -------------------------------------
        if (uri.endsWith("/add")) {
            req.setAttribute("action", "add");
            req.setAttribute("user", new User());
            req.getRequestDispatcher("/views/admin/user-form.jsp").forward(req, resp);
            return;
        }

        // -------------------------------------
        // 3. TRANG SỬA NGƯỜI DÙNG
        // -------------------------------------
        if (uri.endsWith("/edit")) {
            String id = req.getParameter("id");
            req.setAttribute("action", "update");
            req.setAttribute("user", userDAO.findById(id));
            req.getRequestDispatcher("/views/admin/user-form.jsp").forward(req, resp);
            return;
        }

        // -------------------------------------
        // 4. XOÁ NGƯỜI DÙNG
        // -------------------------------------
        if (uri.endsWith("/delete")) {
            String id = req.getParameter("id");
            userDAO.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/user");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String action = req.getParameter("action");

        // Lấy dữ liệu form
        String id = req.getParameter("id");
        String fullname = req.getParameter("fullname");
        String password = req.getParameter("password");
        String birthday = req.getParameter("birthday");
        boolean gender = "1".equals(req.getParameter("gender"));
        String mobile = req.getParameter("mobile");
        String email = req.getParameter("email");
        boolean role = "1".equals(req.getParameter("role"));

        User u = new User(id, password, fullname, birthday, gender, mobile, email, role);

        // XỬ LÝ ADD USER
        if ("add".equals(action)) {
            if (userDAO.exists(id)) {
                req.setAttribute("error", "ID đã tồn tại!");
                req.setAttribute("user", u);
                req.setAttribute("action", "add");
                req.getRequestDispatcher("/views/admin/user-form.jsp").forward(req, resp);
                return;
            }
            userDAO.insert(u);
        }

        // XỬ LÝ UPDATE USER
        if ("update".equals(action)) {
            userDAO.update(u);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/user");
    }
}
