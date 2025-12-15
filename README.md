# ABC News - CMS System

Hệ thống quản lý nội dung tin tức (CMS) được xây dựng bằng **Java Servlet, JSP** và **SQL Server**. Dự án hỗ trợ phân quyền người dùng (Admin/Reporter), quản lý bài viết, danh mục và đa ngôn ngữ.

![Project Status](https://img.shields.io/badge/status-active-success.svg)
![Java](https://img.shields.io/badge/Java-21-orange.svg)
![Database](https://img.shields.io/badge/SQL_Server-2019+-red.svg)

## 🚀 Tính năng chính

### 1. Phân quyền người dùng
* **Khách (Guest):** Xem tin tức, tìm kiếm theo danh mục, gửi liên hệ, đăng ký nhận bản tin (Newsletter).
* **Phóng viên (Reporter):**
    * Đăng nhập/Đăng xuất.
    * Quản lý bài viết cá nhân (Thêm, Sửa, Xóa).
    * Xem thống kê lượt xem bài viết của mình.
    * Cập nhật hồ sơ cá nhân.
* **Quản trị viên (Admin):**
    * Quyền hạn cao nhất.
    * Quản lý toàn bộ bài viết, danh mục, người dùng.
    * Quản lý danh sách đăng ký bản tin (Newsletter).
    * Xem thống kê tổng quan hệ thống.

### 2. Chức năng nổi bật
* **Đa ngôn ngữ (I18n):** Hỗ trợ chuyển đổi Tiếng Việt / Tiếng Anh (Chưa hoàn thiện vì lười).
* **Gửi Email:** Tích hợp JavaMail để gửi phản hồi liên hệ.
* **Thống kê:** Dashboard trực quan cho Admin và Reporter.
* **Giao diện:** Responsive cơ bản, tích hợp Tailwind CSS.

## 🛠️ Công nghệ sử dụng

* **Backend:** Java Servlet, JSP, JSTL.
* **Database:** Microsoft SQL Server.
* **Frontend:** HTML5, CSS3, Tailwind CSS (CDN).
* **Build Tool:** Maven.
* **Server:** Apache Tomcat 9.0.
* **IDE:** Eclipse / IntelliJ IDEA.

## ⚙️ Cài đặt và Hướng dẫn chạy

### 1. Yêu cầu hệ thống
* JDK 21 trở lên.
* SQL Server (bất kỳ phiên bản nào hỗ trợ JDBC).
* Apache Tomcat 9.0.

### 2. Thiết lập Cơ sở dữ liệu
1.  Mở SQL Server Management Studio (SSMS).
2.  Chạy script `sql/abcNews.sql` để tạo Database và các bảng.
3.  Script đã bao gồm dữ liệu mẫu (Admin, Reporter, News).

### 3. Cấu hình kết nối
Mở file `src/main/java/com/abcnews/utils/XJdbc.java` và cập nhật thông tin kết nối nếu cần:

```java
var dburl = "jdbc:sqlserver://localhost:1433;database=abcNews;encrypt=true;trustServerCertificate=true;";
var username = "sa"; // Tài khoản SQL của bạn
var password = "123"; // Mật khẩu SQL của bạn

```

###4. Chạy dự án1. Clone repo về máy:
```bash
git clone [https://github.com/your-username/ABCNews-CMS.git](https://github.com/your-username/ABCNews-CMS.git)

```


2. Import dự án vào Eclipse/IntelliJ dưới dạng **Maven Project**.
3. Click chuột phải vào project -> **Run As** -> **Run on Server**.
4. Truy cập: `http://localhost:8080/CodeDemo/home`

##🔐 Tài khoản Demo| Vai trò | Tên đăng nhập | Mật khẩu |
| --- | --- | --- |
| **Admin** | `admin` | `123` |
| **Reporter** | `pv001` | `123` |
| **Reporter** | `pv002` | `123` |

##📂 Cấu trúc thư mục```text
CodeDemo/
├── src/
│   ├── main/
│   │   ├── java/com/abcnews/   # Source code Java (DAO, Entity, Servlet, Utils)
│   │   ├── resources/          # File cấu hình
│   │   └── webapp/
│   │       ├── views/          # Các file JSP (admin, home, reporter...)
│   │       ├── META-INF/
│   │       └── WEB-INF/
├── sql/                        # Script tạo Database
├── pom.xml                     # Maven dependencies
└── README.md                   # Tài liệu dự án

```

##📝Dự án này là bài tập thực hành để rèn luyện kỹ năng Java Web. Một số điểm có thể cải thiện thêm trong tương lai:

* [ ] Áp dụng Connection Pooling (HikariCP) để tối ưu kết nối DB.
* [ ] Mã hóa mật khẩu (BCrypt) thay vì lưu plain text.
* [ ] Thêm chức năng quên mật khẩu.
* [ ] Tách biệt file CSS/JS ra khỏi file JSP.

---

**Author:** [Nguyen Dai Vinh Khanh]

```

```
