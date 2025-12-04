package com.abcnews.servlet.admin;

import com.abcnews.dao.CategoryDAO;
import com.abcnews.daoimpl.CategoryDAOImpl;
import com.abcnews.entity.Category;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/category")
public class AdminCategoryServlet extends HttpServlet {

    private CategoryDAO dao = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");

        if ("add".equals(action)) {

            req.getRequestDispatcher("/views/admin/category-form.jsp").forward(req, resp);
            return;

        } else if ("edit".equals(action)) {

            String id = req.getParameter("id");
            req.setAttribute("category", dao.findById(id));
            req.getRequestDispatcher("/views/admin/category-form.jsp").forward(req, resp);
            return;

        } else if ("delete".equals(action)) {

            dao.delete(req.getParameter("id"));
            resp.sendRedirect(req.getContextPath() + "/admin/category");
            return;
        }

        // LIST
        req.setAttribute("list", dao.findAll());
        req.getRequestDispatcher("/views/admin/category-form.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String id = req.getParameter("id");
        String name = req.getParameter("name");

        Category c = new Category(id, name);

        if (dao.findById(id) == null) {
            dao.insert(c);
        } else {
            dao.update(c);
        }

        resp.sendRedirect(req.getContextPath() + "/admin/category");
    }
}
