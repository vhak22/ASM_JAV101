# 📰 ABC News - Hệ Thống Quản Lý Tin Tức (CMS)

> **Môn học:** Lập Trình Web Cơ Bản (JAV101) (Java Servlet & JSP)  
> **Sinh viên thực hiện:** Nguyễn Đài Vĩnh Khánh  
> **Trạng thái:**  Đang phát triển (Development)

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
```
### Bước 4: Chạy dự án
Import dự án vào Eclipse dưới dạng Existing Maven Project.
Click chuột phải vào Project -> Run As -> Run on Server.
Truy cập địa chỉ: http://localhost:8080/CodeDemo/home

### 🔐 Tài Khoản Demo (Có sẵn trong DB)
| Vai trò | Tài khoản | Mật khẩu | Ghi chú |
| :--- | :--- | :--- | :--- |
| **Admin** | `admin` | `123` | Quản trị viên cao cấp |
| **Reporter** | `pv001` | `123` | Phóng viên |
| **User** | `user01` | `123` | Người dùng thường |

## 📂 Cấu Trúc Dự Án

Dự án được tổ chức theo chuẩn **Maven Dynamic Web Project**, tuân thủ mô hình **MVC (Model-View-Controller)**.

```text
CodeDemo
├── sql/
│   └── abcNews.sql                 # Script SQL tạo Database và dữ liệu mẫu
│
├── src/main/java/com/abcnews/
│   ├── dao/                        # Data Access Object (Interfaces)
│   │   ├── CrudDAO.java            # Interface generic chung cho các DAO
│   │   ├── UserDAO.java, NewsDAO.java...
│   │
│   ├── daoimpl/                    # Implementation của DAO (Logic truy vấn SQL)
│   │   ├── UserDAOImpl.java, NewsDAOImpl.java...
│   │
│   ├── entity/                     # Các POJO class mapping với bảng trong DB
│   │   ├── User.java, News.java, Category.java, Newsletter.java
│   │
│   ├── filter/                     # Servlet Filters (Kiểm soát quyền truy cập)
│   │   ├── AdminFilter.java        # Chặn truy cập trái phép vào /admin/*
│   │   ├── ReporterFilter.java     # Chặn truy cập trái phép vào /reporter/*
│   │
│   ├── lang/                       # Tài nguyên đa ngôn ngữ (I18n)
│   │   ├── messages_vi.properties  # Tiếng Việt
│   │   ├── messages_en.properties  # Tiếng Anh
│   │
│   ├── servlet/                    # Controllers (Xử lý request từ người dùng)
│   │   ├── admin/                  # Các Servlet dành cho Admin (Users, News, Dashboard...)
│   │   ├── reporter/               # Các Servlet dành cho Reporter (My News, Profile...)
│   │   ├── HomeServlet.java, LoginServlet.java...
│   │
│   └── utils/                      # Các lớp tiện ích dùng chung
│       ├── XJdbc.java              # Helper quản lý kết nối và thực thi SQL
│       ├── XQuery.java             # Helper hỗ trợ mapping ResultSet sang Entity
│
├── src/main/webapp/
│   ├── views/                      # Chứa các file giao diện (View)
│   │   ├── admin/                  # Giao diện quản trị (JSP)
│   │   ├── pv/ (hoặc reporter/)    # Giao diện cho phóng viên
│   │   ├── home/                   # Giao diện trang chủ (Index, Top5View...)
│   │   ├── auth/                   # Giao diện xác thực (Login, Register...)
│   │   ├── layout/                 # Các thành phần dùng chung (Header, Footer)
│   │   └── style/                  # CSS (styleAll.css)
│   │
│   ├── META-INF/
│   └── WEB-INF/                    # Cấu hình web (web.xml nếu có)
│
└── pom.xml                         # Quản lý dependencies (Maven)
```
## 🔮 Kế Hoạch Cải Thiện & Nâng Cấp (Roadmap)

Dự án hiện tại đã hoàn thiện các chức năng cơ bản (MVP). Tuy nhiên, để hệ thống sẵn sàng cho môi trường thực tế (Production-ready), các cải tiến sau sẽ được ưu tiên thực hiện trong phiên bản tới:

### 1. 🛡️ Bảo Mật & An Toàn Dữ Liệu (High Priority)
- [ ] **Mã hóa mật khẩu:** Thay thế việc lưu mật khẩu dạng thô (Plain text) hiện tại bằng thuật toán băm **BCrypt** hoặc **Argon2** để bảo vệ tài khoản người dùng.
- [ ] **Quản lý biến môi trường:** Loại bỏ các thông tin nhạy cảm (DB credentials, Email password) đang bị hardcode trong source code (`DBConnect.java`, `ContactServlet.java`) và chuyển sang file cấu hình `.env` hoặc biến môi trường hệ thống.
- [ ] **Cơ chế Filter:** Kích hoạt lại và tối ưu hóa `AdminFilter` & `ReporterFilter` để kiểm soát chặt chẽ quyền truy cập vào các đường dẫn nội bộ, ngăn chặn truy cập trái phép (IDOR).

### 2. ⚡ Hiệu Năng & Kiến Trúc
- [ ] **Connection Pooling:** Tích hợp thư viện **HikariCP** thay thế cho cơ chế `DriverManager` hiện tại để quản lý kết nối Database hiệu quả hơn, giải quyết vấn đề nghẽn cổ chai khi có nhiều người dùng đồng thời.
- [ ] **Thread Safety:** Viết lại lớp tiện ích `XJdbc` để loại bỏ biến `static Connection`, đảm bảo an toàn luồng (Thread-safety) trong môi trường Web đa người dùng.
- [ ] **Phân trang (Pagination):** Cải thiện các câu truy vấn SQL lấy danh sách bài viết (`findAll`), bổ sung logic phân trang (Offset-Fetch) để tối ưu tốc độ tải trang khi dữ liệu lớn.

### 3. 🎨 Giao Diện & Trải Nghiệm (UI/UX)
- [ ] **Clean Code Frontend:** Tách biệt hoàn toàn mã CSS/JS ra khỏi các file JSP (`styleAll.css`, `script.js`) để code gọn gàng, dễ bảo trì và tận dụng caching của trình duyệt.
- [ ] **Responsive Design:** Tối ưu hóa giao diện Admin và Dashboard trên thiết bị di động.

### 4. 🧩 Tính Năng Mới
- [ ] **Quên mật khẩu:** Tận dụng module gửi mail (`JavaMail`) đã có để xây dựng chức năng lấy lại mật khẩu qua OTP.
- [ ] **Bình luận:** Cho phép độc giả bình luận dưới bài viết (tích hợp Captcha chống spam).
- [ ] **Upload ảnh:** Tích hợp Cloudinary hoặc lưu trữ cục bộ thay vì chỉ dùng link ảnh URL.

---



