IF DB_ID('ABCNews') IS NULL
BEGIN
    CREATE DATABASE ABCNews;
END
GO

USE ABCNews;
GO

IF OBJECT_ID('dbo.Categories', 'U') IS NOT NULL 
    DROP TABLE dbo.Categories;
GO

CREATE TABLE dbo.Categories (
    Id          NVARCHAR(50)    NOT NULL PRIMARY KEY,
    Name        NVARCHAR(255)   NOT NULL
);
GO

IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL 
    DROP TABLE dbo.Users;
GO

CREATE TABLE dbo.Users (
    Id          NVARCHAR(50)    NOT NULL PRIMARY KEY,
    Password    NVARCHAR(255)   NOT NULL,
    Fullname    NVARCHAR(255)   NOT NULL,
    Birthday    DATE            NULL,
    Gender      BIT             NULL,
    Mobile      NVARCHAR(20)    NULL,
    Email       NVARCHAR(255)   NULL,
    Role        INT             NOT NULL    -- 0=Độc giả, 1=Phóng viên, 2=Admin
);
GO

IF OBJECT_ID('dbo.News', 'U') IS NOT NULL 
    DROP TABLE dbo.News;
GO

CREATE TABLE dbo.News (
    Id              NVARCHAR(50)    NOT NULL PRIMARY KEY,
    Title           NVARCHAR(255)   NOT NULL,
    Content         NVARCHAR(MAX)   NOT NULL,
    Image           NVARCHAR(500)   NULL,
    PostedDate      DATE            NOT NULL,
    Author          NVARCHAR(50)    NOT NULL,                -- FK -> Users(Id)
    ViewCount       INT             DEFAULT 0,
    CategoryId      NVARCHAR(50)    NOT NULL,                -- FK -> Categories(Id)
    Home            BIT             DEFAULT 0,
		
    CONSTRAINT FK_News_Author FOREIGN KEY (Author)
        REFERENCES dbo.Users(Id),

    CONSTRAINT FK_News_Category FOREIGN KEY (CategoryId)
        REFERENCES dbo.Categories(Id)
);
GO


IF OBJECT_ID('dbo.Newsletters', 'U') IS NOT NULL 
    DROP TABLE dbo.Newsletters;
GO

CREATE TABLE dbo.Newsletters (
    Email       NVARCHAR(255)   NOT NULL PRIMARY KEY,
    Enabled     BIT             NOT NULL DEFAULT 1
);
GO
SELECT Email FROM dbo.Newsletters WHERE Email = 1

USE ABCNews;
GO

-- =========================
-- 1. Categories (Loại tin)
-- =========================
INSERT INTO Categories (Id, Name) VALUES
('POL', N'Chính trị'),
('SOC', N'Xã hội'),
('TEC', N'Công nghệ'),
('SPO', N'Thể thao'),
('ENT', N'Giải trí');
GO

-- =========================
-- 2. Users (Tài khoản)
-- =========================
INSERT INTO Users (Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role) VALUES
('admin', '123', N'Nguyễn Quản Trị', '1990-01-01', 1, '0988001122', 'admin@abcnews.vn', 2),   -- Admin
('pv001', '123', N'Lê Phóng Viên', '1995-03-12', 0, '0909123123', 'pv001@abcnews.vn', 1),    -- Phóng viên
('pv002', '123', N'Trần Minh Phúc', '1998-07-20', 1, '0912333444', 'pv002@abcnews.vn', 1),    -- Phóng viên
('user01', '123', N'Nguyễn Độc Giả', '2000-05-11', 1, '0912004556', 'docgia01@gmail.com', 0); -- Độc giả
GO
INSERT INTO Users (Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role) VALUES
('admin01', '123', N'Hồ Ngọc Thiên Vy', '2004-01-07', 1, '0708850129', 'admin@abcnews.vn', 2),-- Admin
('user03', '123', N'Lê Độc Giả', '2010-05-11', 0, '0931489629', 'docgia01@gmail.com', 0),
('user02', '123', N'Phan Độc Giả', '2003-05-11', 1, '0389989499', 'docgia01@gmail.com', 0),
('user04', '123', N'Hồ Độc Giả', '2005-05-11', 0, '0382886288', 'docgia01@gmail.com', 0);
GO
INSERT INTO Users (Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role) VALUES
('pv003', '123', N'Phạm Thị Ngọc Thảo', '1995-03-12', 0, '0909123123', 'pv001@abcnews.vn', 1),    -- Phóng viên
('pv004', '123', N'Hồ Phước An', '1998-07-20', 1, '0912333444', 'pv002@abcnews.vn', 1),
('pv005', '123', N'Đoàn Duy Bằng', '1995-03-12', 0, '0909123123', 'pv001@abcnews.vn', 1),    -- Phóng viên
('pv006', '123', N'Nguyễn Ngọc Huệ', '1998-07-20', 1, '0912333444', 'pv002@abcnews.vn', 1),
('pv007', '123', N'Học Sinh Thủ Đức', '1995-03-12', 0, '0909123123', 'pv001@abcnews.vn', 1),    -- Phóng viên
('pv008', '123', N'Đào Hồng Đạt', '1998-07-20', 0, '0912333444', 'pv002@abcnews.vn', 1);
GO

select * from Users
-- =========================
-- 3. News (Bản tin)
-- =========================
INSERT INTO News (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) VALUES
('N001', N'Tin công nghệ mới', 
 N'Apple ra mắt sản phẩm mới trong sự kiện tháng 10.', 
 'images/apple_event.jpg', '2025-01-10', 'pv001', 120, 'TEC', 1),

('N002', N'Đội tuyển quốc gia chiến thắng', 
 N'Đội tuyển Việt Nam giành chiến thắng 2-0 trong trận giao hữu.', 
 'images/vn_team.jpg', '2025-01-12', 'pv002', 450, 'SPO', 1),

('N003', N'Giá xăng tiếp tục giảm', 
 N'Bộ Công Thương thông báo giảm giá xăng từ 1/1.', 
 'images/fuel.jpg', '2025-01-05', 'pv001', 210, 'SOC', 0),

('N004', N'Phim mới ra mắt', 
 N'Bom tấn Hollywood đạt doanh thu kỷ lục trong tuần đầu.', 
 'images/movie.jpg', '2025-01-15', 'pv002', 340, 'ENT', 0);
GO
SELECT * FROM News
-- =========================
-- 3. News (Bản tin)
-- =========================
INSERT INTO News (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) VALUES
('N085', N'Khai mạc triển lãm công nghệ',
	N'TechExpo 2025 thu hút hàng nghìn người tham dự tại TP.HCM.', 
	'images/techexpo.jpg', '2025-01-22', 'pv003', 512, 'TEC', 1),

('N086', N'Chính sách thuế mới', 
	N'Bộ Tài chính ban hành chính sách thuế hỗ trợ doanh nghiệp nhỏ.', 
	'images/tax_policy.jpg', '2025-01-25', 'pv004', 389, 'SOC', 0),

('N087', N'Lễ hội âm nhạc quốc tế', 
	N'Hàng loạt nghệ sĩ nổi tiếng biểu diễn tại lễ hội âm nhạc mùa xuân.', 
	'images/music_festival.jpg', '2025-01-28', 'pv002', 678, 'ENT', 1),

('N088', N'Sáng kiến năng lượng xanh', 
	N'Việt Nam đẩy mạnh phát triển năng lượng tái tạo.', 
	'images/green_energy.jpg', '2025-01-30', 'pv002', 432, 'SPO', 0),

('N089', N'Giải bóng đá học sinh toàn quốc', 
	N'Chung kết giải bóng đá học sinh diễn ra tại Hà Nội.', 
	'images/school_football.jpg', '2025-02-01', 'pv006', 745, 'SPO', 1),

('N090', N'Startup Việt gọi vốn thành công', 
	N'Công ty khởi nghiệp EcoLife nhận đầu tư 2 triệu USD.', 
	'images/startup.jpg', '2025-02-03', 'pv003', 812, 'SOC', 0),

('N091', N'Hội chợ việc làm mùa xuân', 
	N'Hơn 100 doanh nghiệp tham gia tuyển dụng tại TP.HCM.', 
	'images/jobfair.jpg', '2025-02-05', 'pv007', 290, 'SPO', 1),

('W092', N'Phát hiện hành tinh mới', 
	N'NASA công bố hành tinh có điều kiện sống giống Trái Đất.', 
	'images/new_planet.jpg', '2025-02-07', 'pv008', 1023, 'TEC', 0),

('W093', N'Cuộc thi sáng tạo trẻ', 
	N'Sinh viên toàn quốc tranh tài tại cuộc thi sáng tạo năm 2025.', 
	'images/innovation.jpg', '2025-02-10', 'pv001', 376, 'TEC', 1),

('W094', N'Hội thảo quốc tế về môi trường', 
	N'Các chuyên gia bàn luận giải pháp bảo vệ môi trường toàn cầu.', 
	'images/environment.jpg', '2025-02-12', 'pv004', 654, 'SPO', 0),

('W095', N'Phim tài liệu về lịch sử Việt Nam', 
	N'Bộ phim “Dòng chảy lịch sử” ra mắt khán giả truyền hình.', 
	'images/history_doc.jpg', '2025-02-15', 'pv005', 489, 'ENT', 1),

('W096', N'Cập nhật thị trường chứng khoán',
	N'VN-Index tăng nhẹ sau phiên giao dịch đầu tuần.', 
	'images/stock_market.jpg', '2025-02-17', 'pv006', 721, 'SOC', 0),

('W097', N'Hội nghị AI toàn cầu', 
	N'Các chuyên gia AI thảo luận về tương lai trí tuệ nhân tạo.', 
	'images/ai_summit.jpg', '2025-02-20', 'pv008', 1345, 'TEC', 1),

('W098', N'Sự kiện văn hóa dân gian', 
	N'Trình diễn múa rối nước tại lễ hội truyền thống ở Bắc Ninh.', 
	'images/folk_event.jpg', '2025-02-22', 'pv007', 598, 'ENT', 0),

('W099', N'Chính phủ hỗ trợ startup', 
	N'Gói hỗ trợ tài chính mới cho doanh nghiệp khởi nghiệp Việt Nam.', 
	'images/government_support.jpg', '2025-02-25', 'pv003', 845, 'SOC', 1),

('W100', N'Triển lãm ảnh nghệ thuật quốc tế', 
	N'Tác phẩm nghệ thuật từ 20 quốc gia được trưng bày tại TP.HCM.', 
	'images/art_exhibition.jpg', '2025-02-28', 'pv002', 410, 'ENT', 0),

('W101', N'Giải thưởng công nghệ Việt Nam', 
	N'Vinh danh các sản phẩm công nghệ xuất sắc năm 2025.', 
	'images/tech_award.jpg', '2025-03-01', 'pv001', 980, 'TEC', 1),

('W102', N'Khởi động chiến dịch bảo vệ rừng', 
	N'Tình nguyện viên tham gia trồng cây tại Tây Nguyên.', 
	'images/forest_campaign.jpg', '2025-03-03', 'pv004', 560, 'SPO', 0),

('W103', N'Ra mắt ứng dụng học trực tuyến mới', 
	N'Ứng dụng Edulink giúp học sinh học tập hiệu quả hơn.', 
	'images/edulink.jpg', '2025-03-05', 'pv005', 670, 'TEC', 1),

('W104', N'Lễ hội sách TP.HCM', 
	N'Hàng nghìn đầu sách được giới thiệu tại lễ hội sách năm nay.', 
	'images/book_fair.jpg', '2025-03-07', 'pv006', 730, 'ENT', 0)

GO

-- =========================
-- 4. Newsletters (Email nhận tin)
-- =========================
INSERT INTO Newsletters (Email, Enabled) VALUES
('user1@gmail.com', 1),
('user2@yahoo.com', 1),
('user3@hotmail.com', 0);
GO
SELECT * FROM Users
go
SELECT * FROM News
go
SELECT * FROM Newsletters
go
SELECT * FROM Categories
go
SELECT * FROM News WHERE CategoryId='POL' ORDER BY PostedDate DESC
use ABCNews
SELECT * FROM Users WHERE id='admin' AND password='123'
SELECT * FROM News ORDER BY PostedDate DESC
SELECT TOP 5 * FROM News 
ORDER BY PostedDate DESC;
UPDATE News SET ViewCount='900', Home=1 WHERE Id='W104'
use ABCNews