package com.abcnews.dao;

import java.util.List;

/**
 * Interface chung định nghĩa các hoạt động CRUD cơ bản (Create, Read, Update, Delete).
 *
 * @param <T> Loại đối tượng Entity mà DAO này xử lý (ví dụ: News, User, Category).
 * @param <K> Loại của khóa chính (Primary Key) của Entity (ví dụ: String).
 */
public interface CrudDAO<T, K> {

    /**
     * Thêm một Entity mới vào cơ sở dữ liệu.
     * @param entity Đối tượng Entity cần thêm.
     */
    void insert(T entity);

    /**
     * Cập nhật thông tin của một Entity đã tồn tại trong cơ sở dữ liệu.
     * @param entity Đối tượng Entity chứa thông tin mới.
     */
    void update(T entity);

    /**
     * Xóa một Entity khỏi cơ sở dữ liệu dựa trên khóa chính.
     * @param key Khóa chính của Entity cần xóa.
     */
    void delete(K key);

    /**
     * Tìm kiếm và trả về một Entity dựa trên khóa chính.
     * @param key Khóa chính của Entity cần tìm.
     * @return Entity tương ứng, hoặc null nếu không tìm thấy.
     */
    T findById(K key);

    /**
     * Truy xuất và trả về tất cả các Entity.
     * @return Danh sách các Entity.
     */
    List<T> findAll();
}