package TEST;
import com.abcnews.dao.NewsDAO;
import com.abcnews.daoimpl.NewsDAOImpl;
import com.abcnews.entity.News;

import java.util.List;

import com.abcnews.dao.NewsDAO;

public class TestConnection {
    public static void main(String[] args) {
    	NewsDAO newsDAO = new NewsDAOImpl();
    	List<News> news = newsDAO.findAll();
    	for (News n : news) {
    	    System.out.println(n.getId());
    	    System.out.println(n.getPostedDate());
    	    System.out.println(n.getImage());
    	    System.out.println(n.getContent());
    	}
    }
}