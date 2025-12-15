# 📰 ABC News - Hệ Thống Quản Lý Tin Tức (CMS)

> **Môn học:** Java Servlet & JSP  
> **Sinh viên thực hiện:** Vĩnh Khánh  
> **Trạng thái:** 🟢 Đang phát triển (Development)

Hệ thống CMS tin tức hoàn chỉnh được xây dựng theo mô hình **MVC (Model-View-Controller)**, hỗ trợ đa nền tảng người dùng (Độc giả, Phóng viên, Quản trị viên) với đầy đủ các chức năng quản lý nội dung, phân quyền và đa ngôn ngữ.

---

## 🛠 Công Nghệ Sử Dụng

Dự án được xây dựng trên nền tảng Java Web hiện đại:

* **Ngôn ngữ:** Java 21
* **Nền tảng Web:** Servlet 4.0, JSP, JSTL 1.2
* **Cơ sở dữ liệu:** Microsoft SQL Server 2019+
* **Thư viện hỗ trợ:**
    * `mssql-jdbc` (Kết nối Database)
    * `lombok` (Giảm thiểu boilerplate code)
    * `javax.mail` (Gửi email liên hệ)
    * `commons-beanutils` (Mapping dữ liệu Form)
* **Frontend:** HTML5, CSS3, Tailwind CSS (CDN)
* **Công cụ quản lý:** Maven, Eclipse/IntelliJ IDEA
* **Server:** Apache Tomcat 9.0

---

## 🚀 Tính Năng Chi Tiết

### 1. 👤 Phân Hệ Người Dùng (Public)
* **Trang chủ:** Hiển thị tin nổi bật (Top 5), tin mới nhất theo danh mục.
* **Đa ngôn ngữ:** Chuyển đổi linh hoạt Tiếng Việt (VN) / Tiếng Anh (EN).
* **Xem tin tức:** Xem chi tiết bài viết, tin cùng chuyên mục.
* **Tương tác:** Gửi liên hệ (Contact) qua Email, Đăng ký nhận bản tin (Newsletter).

### 2. 📝 Phân Hệ Phóng Viên (Reporter)
* **Dashboard:** Thống kê tổng quan lượt xem, số bài viết cá nhân.
* **Quản lý bài viết:**
    * Thêm bài viết mới.
    * Chỉnh sửa / Xóa bài viết của chính mình.
    * Upload hình ảnh (Link URL).
* **Cá nhân:** Cập nhật thông tin hồ sơ (Profile).

### 3. 🛡️ Phân Hệ Quản Trị (Admin)
* **Dashboard:** Thống kê toàn hệ thống (Tổng bài viết, Users, Categories).
* **Quản lý người dùng:** Thêm, xóa, sửa, phân quyền (Admin/Reporter).
* **Quản lý danh mục:** CRUD các thể loại tin tức.
* **Quản lý bài viết:** Duyệt, chỉnh sửa hoặc xóa bất kỳ bài viết nào.
* **Quản lý Newsletter:** Xem danh sách email đăng ký, bật/tắt trạng thái nhận tin.

---

## ⚙️ Hướng Dẫn Cài Đặt & Chạy

### Bước 1: Chuẩn bị môi trường
Đảm bảo máy bạn đã cài đặt:
- **JDK 21**
- **Apache Tomcat 9.0**
- **SQL Server**

### Bước 2: Thiết lập Cơ sở dữ liệu
1. Mở SQL Server Management Studio (SSMS).
2. Chạy file script tại đường dẫn: `sql/abcNews.sql`.
   - Script sẽ tạo Database tên `ABCNews` và các bảng cần thiết.
   - Dữ liệu mẫu Admin và Reporter sẽ được tự động thêm vào.

### Bước 3: Cấu hình kết nối
Mở file `src/main/java/com/abcnews/utils/XJdbc.java` và cập nhật thông tin nếu cần:

```java
// Cấu hình JDBC URL, User và Password của SQL Server
String dburl = "jdbc:sqlserver://localhost:1433;database=abcNews;encrypt=true;trustServerCertificate=true;";
String username = "sa"; 
String password = "123";



