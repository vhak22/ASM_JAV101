package com.abcnews.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.abcnews.entity.News;


/**
 * Lớp tiện ích hỗ trợ làm việc với CSDL quan hệ
 *
 * @author NghiemN
 * @version 1.0
 */
public class XJdbc {

    private static Connection connection;

    /**
     * Mở kết nối nếu chưa mở hoặc đã đóng
     *
     * @return Kết nối đã sẵn sàng
     */
    public static Connection openConnection() {
        var driver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
        var dburl = "jdbc:sqlserver://localhost:1433;database=abcNews;encrypt=true;trustServerCertificate=true;";
        var username = "sa";
        var password = "123";
        try {
            if (!XJdbc.isReady()) {
                Class.forName(driver);
                connection = DriverManager.getConnection(dburl, username, password);
            }
        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(e);
        }
        return connection;
    }

    /**
     * Đóng kết nối
     */
    public static void closeConnection() {
        try {
            if (XJdbc.isReady()) {
                connection.close();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Kiểm tra kết nối đã sẵn sàng hay chưa
     * 
     * @return true nếu kết nối đã được mở
     */
    public static boolean isReady() {
        try {
            return (connection != null && !connection.isClosed());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Thao tác dữ liệu
     *
     * @param sql    câu lệnh SQL (INSERT, UPDATE, DELETE)
     * @param values các giá trị cung cấp cho các tham số trong SQL
     * @return số lượng bản ghi đã thực hiện
     * @throws RuntimeException không thực thi được câu lệnh SQL
     */
    public static int executeUpdate(String sql, Object... values) {
        try {
            var stmt = XJdbc.getStmt(sql, values);
            return stmt.executeUpdate();
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    /**
     * Truy vấn dữ liệu
     *
     * @param sql    câu lệnh SQL (SELECT)
     * @param values các giá trị cung cấp cho các tham số trong SQL
     * @return tập kết quả truy vấn
     * @throws RuntimeException không thực thi được câu lệnh SQL
     */
    public static ResultSet executeQuery(String sql, Object... values) {
        try {
            var stmt = XJdbc.getStmt(sql, values);
            return stmt.executeQuery();
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    /**
     * Truy vấn một giá trị
     *
     * @param <T>    kiểu dữ liệu kết quả
     * @param sql    câu lệnh SQL (SELECT)
     * @param values các giá trị cung cấp cho các tham số trong SQL
     * @return giá trị truy vấn hoặc null
     * @throws RuntimeException không thực thi được câu lệnh SQL
     */
    public static <T> T getValue(String sql, Object... values) {
        try {
            var resultSet = XJdbc.executeQuery(sql, values);
            if (resultSet.next()) {
                return (T) resultSet.getObject(1);
            }
            return null;
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
    }

    /**
     * Tạo PreparedStatement từ câu lệnh SQL/PROC
     *
     * @param sql    câu lệnh SQL/PROC
     * @param values các giá trị cung cấp cho các tham số trong SQL/PROC
     * @return đối tượng đã tạo
     * @throws SQLException không tạo được PreparedStatement
     */
    private static PreparedStatement getStmt(String sql, Object... values) throws SQLException {
        var conn = XJdbc.openConnection();
        var stmt = sql.trim().startsWith("{") ? conn.prepareCall(sql) : conn.prepareStatement(sql);
        for (int i = 0; i < values.length; i++) {
            stmt.setObject(i + 1, values[i]);
        }
        return stmt;
    }

    /**
     * Trả về kết nối hiện tại (hoặc mở mới nếu chưa có)
     * 
     * @return kết nối CSDL đang mở
     */
    public static Connection getConnection() {
        return openConnection();
    }
     public static void main(String[] args) {
     demo1();
//     demo2();
//     demo3();
     }
     private static void demo1() {
    	 String sql = "SELECT * FROM News";
	     List<News> aws = new ArrayList<News>();
	     aws = XQuery.getBeanList(News.class, sql);
	     for(News item:aws) {
	    	 if(item.isHome()==true) {
		    	 System.out.println("ID: " + item.getId());
			     System.out.println("Title: " + item.getTitle());
			     System.out.println("Content: " + item.getContent());
			     System.out.println("Image: " + item.getImage());
			     System.out.println("Home: " + item.isHome());
			     System.out.println("");
		     } else{


		     }
	     }

		  
     }
//    //
     private static void demo2() {

     }
//    //
//    // private static void demo3() {
//    // String sql = "DELETE FROM Drinks WHERE UnitPrice < ?";
//    // var count = XJdbc.executeUpdate(sql, 0.0);
//    // }
}
