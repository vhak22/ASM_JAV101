package com.abcnews.daoimpl;

import com.abcnews.dao.UserDAO;
import com.abcnews.entity.User;
import com.abcnews.utils.XJdbc; // Sử dụng XJdbc thay cho DBConnect

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO {

    private User map(ResultSet rs) throws SQLException {
        User u = new User();
        u.setId(rs.getString("id"));
        u.setPassword(rs.getString("password"));
        u.setFullname(rs.getString("fullname"));
        u.setBirthday(rs.getString("birthday"));
        u.setGender(rs.getBoolean("gender"));
        u.setMobile(rs.getString("mobile"));
        u.setEmail(rs.getString("email"));
        u.setRole(rs.getBoolean("role"));
        return u;
    }

    // Các câu lệnh SQL được định nghĩa dưới dạng private static final String
    private static final String SQL_INSERT = 
        "INSERT INTO Users(id, password, fullname, birthday, gender, mobile, email, role) "
        + "VALUES(?,?,?,?,?,?,?,?)";
        
    private static final String SQL_UPDATE = 
        "UPDATE Users SET password=?, fullname=?, birthday=?, gender=?, mobile=?, email=?, role=? "
        + "WHERE id=?";
        
    private static final String SQL_DELETE = 
        "DELETE FROM Users WHERE id=?";
        
    private static final String SQL_FIND_BY_ID = 
        "SELECT * FROM Users WHERE id=?";
        
    private static final String SQL_FIND_ALL = 
        "SELECT * FROM Users";
        
    private static final String SQL_LOGIN = 
        "SELECT * FROM Users WHERE id=? AND password=?";
        
    private static final String SQL_EXISTS = 
        "SELECT id FROM Users WHERE id=?";

    @Override
    public void insert(User u) {
        XJdbc.executeUpdate(SQL_INSERT,
            u.getId(),
            u.getPassword(),
            u.getFullname(),
            u.getBirthday(),
            u.isGender(),
            u.getMobile(),
            u.getEmail(),
            u.isRole()
        );
    }

    @Override
    public void update(User u) {
        XJdbc.executeUpdate(SQL_UPDATE,
            u.getPassword(),
            u.getFullname(),
            u.getBirthday(),
            u.isGender(),
            u.getMobile(),
            u.getEmail(),
            u.isRole(),
            u.getId()
        );
    }

    @Override
    public void delete(String id) {
        XJdbc.executeUpdate(SQL_DELETE, id);
    }

    @Override
    public User findById(String id) {
        User u = null;
        try (ResultSet rs = XJdbc.executeQuery(SQL_FIND_BY_ID, id)) {
            if (rs.next()) u = map(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }

    @Override
    public List<User> findAll() {
        List<User> list = new ArrayList<>();
        try (ResultSet rs = XJdbc.executeQuery(SQL_FIND_ALL)) {
            while (rs.next()) list.add(map(rs));
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public User login(String username, String password) {
        User u = null;
        try (ResultSet rs = XJdbc.executeQuery(SQL_LOGIN, username, password)) {
            if (rs.next()) u = map(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }

    @Override
    public boolean exists(String id) {
        // Sử dụng XJdbc.getValue() để kiểm tra sự tồn tại nhanh hơn
        return XJdbc.getValue(SQL_EXISTS, id) != null;
    }
}