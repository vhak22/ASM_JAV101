package com.abcnews.servlet.reporter;

import com.abcnews.dao.NewsDAO;
import com.abcnews.dao.CategoryDAO;
import com.abcnews.daoimpl.NewsDAOImpl;
import com.abcnews.daoimpl.CategoryDAOImpl;
import com.abcnews.entity.Category;
import com.abcnews.entity.News;
import com.abcnews.entity.User;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/reporter/news")
public class ReporterNewsServlet extends HttpServlet {

    private NewsDAO newsDAO = new NewsDAOImpl();
    private CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User reporter = (User) session.getAttribute("user");

        if (reporter == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String action = req.getParameter("action");
        List<Category> categories = categoryDAO.findAll();
       
        if ("add".equals(action)) {
            String id = req.getParameter("id");
            req.setAttribute("news", newsDAO.findById(id));
            req.setAttribute("aws", categories);
            req.getRequestDispatcher("/views/pv/news-form.jsp").forward(req, resp);
            return;
        }
        
        if ("edit".equals(action)) {
            String id = req.getParameter("id");
            req.setAttribute("news", newsDAO.findById(id));
            req.setAttribute("aws", categories);
            req.getRequestDispatcher("/views/pv/news-form.jsp").forward(req, resp);
            return;
        }

        if ("delete".equals(action)) {
            String id = req.getParameter("id");
            newsDAO.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/news");
            return;
        }

        req.setAttribute("categories", categoryDAO.findAll());
        req.setAttribute("myNews", newsDAO.findByReporter(reporter.getId()));

        req.getRequestDispatcher("/views/pv/news.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        User reporter = (User) session.getAttribute("user");

        String idStr = req.getParameter("id");
        String title = req.getParameter("title");
        String content = req.getParameter("content");
        String image = req.getParameter("image");
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));

        News n = new News();
        n.setTitle(title);
        n.setContent(content);
        n.setImage(image);
        n.setCategoryId(String.valueOf(categoryId));
        n.setAuthor(reporter.getId());
        n.setPostedDate(java.sql.Date.valueOf(LocalDate.now()));
        n.setViewCount(0);
        n.setHome(false);

        if (idStr == null || idStr.isEmpty()) {
            newsDAO.insert(n);
        } else {
            n.setId(String.valueOf(idStr));
            newsDAO.update(n);
        }

        resp.sendRedirect("news");
    }
}























































//
//<dependency>
//<groupId>Asmm</groupId>
//<artifactId>Asmm</artifactId>
//<version>0.0.1-SNAPSHOT</version>
//</dependency>