//package com.abcnews.filter;
//
//import com.abcnews.entity.User;
//
//import javax.servlet.*;
//import javax.servlet.annotation.WebFilter;
//import javax.servlet.http.*;
//import java.io.IOException;
//
//@WebFilter("/admin/*")
//public class AdminFilter implements Filter {
//
//    @Override
//    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
//            throws IOException, ServletException {
//
//        HttpServletRequest req = (HttpServletRequest) request;
//        HttpServletResponse resp = (HttpServletResponse) response;
//
//        HttpSession session = req.getSession(false);
//
//        User user = (session != null) ? (User) session.getAttribute("user") : null;
//
//        if (user == null || !user.getRole().equalsIgnoreCase("admin")) {
//            resp.sendRedirect(req.getContextPath() + "/login");
//            return;
//        }
//
//        chain.doFilter(request, response);
//    }
//}
