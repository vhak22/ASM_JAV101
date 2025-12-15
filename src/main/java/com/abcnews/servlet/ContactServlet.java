package com.abcnews.servlet;

import java.io.IOException;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ContactServlet
 */
@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ContactServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setAttribute("a", "- Liên Hệ");
		request.getRequestDispatcher("/views/contact/contact.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("utf-8");
	        response.setCharacterEncoding("utf-8");

	        final String user = "khanhnguyeen2208@gmail.com";
	        final String pass = "YOUR_EMAIL_PASSWORD";

	        String to = request.getParameter("to");
	        String subject = request.getParameter("subject");
	        String content = request.getParameter("content");

	        if (to.isEmpty() || subject.isEmpty() || content.isEmpty()) {
	            request.setAttribute("message", "Vui lòng nhập đầy đủ!");
	        } else {
	            try {
	                Properties props = new Properties();
	                props.put("mail.smtp.auth", "true");
	                props.put("mail.smtp.starttls.enable", "true");
	                props.put("mail.smtp.host", "smtp.gmail.com");
	                props.put("mail.smtp.port", "587");
	                props.put("mail.smtp.ssl.protocols", "TLSv1.2");

	                Session session = Session.getInstance(props, new Authenticator() {
	                    @Override
	                    protected PasswordAuthentication getPasswordAuthentication() {
	                        return new PasswordAuthentication(user, pass);
	                    }
	                });

	                Message mail = new MimeMessage(session);
	                mail.setFrom(new InternetAddress(user));
	                mail.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
	                mail.setSubject(subject);
	                mail.setText(content);

	                Transport.send(mail);
	                request.setAttribute("message", "Gửi email thành công!");

	            } catch (Exception e) {
	                request.setAttribute("message", "Gửi email thất bại: " + e.getMessage());
	            }
	        }

	        request.getRequestDispatcher("/views/contact/contact.jsp").forward(request, response);
	}

}
