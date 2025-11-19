package com.vinhkhanh.utils;


import java.lang.reflect.Method;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class XQuery {

    public static <B> B getSingleBean(Class<B> beanClass, String sql, Object... values) {
        List<B> list = XQuery.getBeanList(beanClass, sql, values);
        if (!list.isEmpty()) {
            return list.get(0);
        }



        return null;
    }

    public static <B> List<B> getBeanList(Class<B> beanClass, String sql, Object... values) {
        List<B> list = new ArrayList<>();
        try {
            ResultSet resultSet = XJdbc.executeQuery(sql, values);
            while (resultSet.next()) {
                list.add(XQuery.readBean(resultSet, beanClass));
            }
        } catch (Exception ex) {
            throw new RuntimeException(ex);
        }
        return list;
    }

    private static <B> B readBean(ResultSet resultSet, Class<B> beanClass) throws Exception {
        B bean = beanClass.getDeclaredConstructor().newInstance();
        Method[] methods = beanClass.getDeclaredMethods();
        for (Method method : methods) {
            String name = method.getName();
            if (name.startsWith("set") && method.getParameterCount() == 1) {
                try {
                    Object value = resultSet.getObject(name.substring(3));
                    method.invoke(bean, value);
                } catch (IllegalAccessException | IllegalArgumentException | SQLException e) {
                    System.out.println(e.getMessage());
                    System.out.printf("+ Column '%s' not found!\r\n", name.substring(3));
                }
            }
        }
        return bean;
    }
    public static <T> List<T> getList(Class<T> typeClass, String sql, Object... values) {
        List<T> list = new ArrayList<>();
        try (ResultSet resultSet = XJdbc.executeQuery(sql, values)) {
            while (resultSet.next()) {
                list.add((T) resultSet.getObject(1));
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
        return list;
    }




}