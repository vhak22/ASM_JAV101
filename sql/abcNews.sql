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
    Role        INT             NOT NULL    --0=Phóng viên, 1=Admin
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
SELECT * FROM Users WHERE Id ='pv006'
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
SELECT TOP 5 * FROM News ORDER BY ViewCount DESC
ORDER BY PostedDate DESC;
UPDATE News SET Author='pv008' WHERE Id='W090'
W101
W099
N090
use ABCNews
select * FROM News WHERE Author = 'pv008'

/*SQL_FIND_LATEST_POST_VIEWS*/
SELECT TOP 1 ViewCount FROM News WHERE Author = 'pv008' ORDER BY PostedDate DESC
/*SQL_SUM_VIEWS_BY_AUTHOR*/
SELECT SUM(ViewCount) FROM News WHERE Author = 'pv006'
/*SQL_COUNT_POSTS_BY_AUTHOR*/
SELECT COUNT(Id) FROM News WHERE Author = 'pv006'

USE ABCNews;
GO

-- =============================================
-- 1. TẠO USER TESTER
-- =============================================
-- Xóa nếu đã tồn tại để tránh lỗi trùng lặp
DELETE FROM Users WHERE Id IN ('tester1', 'tester2');

INSERT INTO Users (Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role) VALUES
('tester1', '123', N'Admin Tester',    '1990-01-01', 1, '0999888777', 'admin.test@abcnews.vn', 1), -- Role 2: Admin
('tester2', '123', N'Reporter Tester', '1995-06-15', 0, '0999666555', 'reporter.test@abcnews.vn', 0); -- Role 1: Reporter
GO

-- =============================================
-- 2. TẠO 50 BÀI VIẾT (10 BÀI/CHỦ ĐỀ)
-- =============================================
-- Xóa các bài test cũ nếu có
DELETE FROM News WHERE Id LIKE 'TEST_%';

INSERT INTO News (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home) VALUES

-- === 1. CHÍNH TRỊ (POL) ===
('TEST_POL_01', N'Chính sách phát triển 2025', N'Nội dung demo về chính trị...', 'images/pol_01.jpg', '2025-01-10', 'tester2', 1050, 'POL', 1),
('TEST_POL_02', N'Hội nghị thượng đỉnh tháng 2', N'Nội dung demo về chính trị...', 'images/pol_02.jpg', '2025-02-12', 'tester2', 1200, 'POL', 0),
('TEST_POL_03', N'Thay đổi luật lao động', N'Nội dung demo về chính trị...', 'images/pol_03.jpg', '2025-03-05', 'tester2', 1890, 'POL', 1),
('TEST_POL_04', N'Hợp tác quốc tế mới', N'Nội dung demo về chính trị...', 'images/pol_04.jpg', '2025-04-15', 'tester2', 1560, 'POL', 0),
('TEST_POL_05', N'Bầu cử hội đồng nhân dân', N'Nội dung demo về chính trị...', 'images/pol_05.jpg', '2025-05-20', 'tester2', 1980, 'POL', 1),
('TEST_POL_06', N'Chiến lược kinh tế vĩ mô', N'Nội dung demo về chính trị...', 'images/pol_06.jpg', '2025-06-11', 'tester2', 1100, 'POL', 0),
('TEST_POL_07', N'Đối ngoại song phương', N'Nội dung demo về chính trị...', 'images/pol_07.jpg', '2025-07-22', 'tester2', 1450, 'POL', 1),
('TEST_POL_08', N'Quy hoạch đô thị mới', N'Nội dung demo về chính trị...', 'images/pol_08.jpg', '2025-08-09', 'tester2', 1700, 'POL', 0),
('TEST_POL_09', N'Cải cách hành chính công', N'Nội dung demo về chính trị...', 'images/pol_09.jpg', '2025-09-30', 'tester2', 1320, 'POL', 1),
('TEST_POL_10', N'Tổng kết quý 4 năm 2025', N'Nội dung demo về chính trị...', 'images/pol_10.jpg', '2025-10-15', 'tester2', 1999, 'POL', 0),

-- === 2. XÃ HỘI (SOC) ===
('TEST_SOC_01', N'Đời sống dân cư đô thị', N'Nội dung demo xã hội...', 'images/soc_01.jpg', '2025-01-15', 'tester2', 1150, 'SOC', 1),
('TEST_SOC_02', N'Vấn đề môi trường biển', N'Nội dung demo xã hội...', 'images/soc_02.jpg', '2025-02-20', 'tester2', 1250, 'SOC', 0),
('TEST_SOC_03', N'Giáo dục vùng cao 2025', N'Nội dung demo xã hội...', 'images/soc_03.jpg', '2025-03-10', 'tester2', 1900, 'SOC', 1),
('TEST_SOC_04', N'Y tế cộng đồng phát triển', N'Nội dung demo xã hội...', 'images/soc_04.jpg', '2025-04-05', 'tester2', 1600, 'SOC', 0),
('TEST_SOC_05', N'Giao thông thông minh', N'Nội dung demo xã hội...', 'images/soc_05.jpg', '2025-05-12', 'tester2', 1080, 'SOC', 1),
('TEST_SOC_06', N'An sinh xã hội mùa mưa', N'Nội dung demo xã hội...', 'images/soc_06.jpg', '2025-06-25', 'tester2', 1340, 'SOC', 0),
('TEST_SOC_07', N'Tình nguyện viên mùa hè', N'Nội dung demo xã hội...', 'images/soc_07.jpg', '2025-07-30', 'tester2', 1750, 'SOC', 1),
('TEST_SOC_08', N'Lễ hội văn hóa ẩm thực', N'Nội dung demo xã hội...', 'images/soc_08.jpg', '2025-08-18', 'tester2', 1420, 'SOC', 0),
('TEST_SOC_09', N'Phong trào xanh sạch đẹp', N'Nội dung demo xã hội...', 'images/soc_09.jpg', '2025-09-02', 'tester2', 1950, 'SOC', 1),
('TEST_SOC_10', N'Câu chuyện nhân văn 2025', N'Nội dung demo xã hội...', 'images/soc_10.jpg', '2025-10-10', 'tester2', 1680, 'SOC', 0),

-- === 3. CÔNG NGHỆ (TEC) ===
('TEST_TEC_01', N'Smartphone màn hình cuộn', N'Review công nghệ...', 'images/tec_01.jpg', '2025-01-05', 'tester2', 1990, 'TEC', 1),
('TEST_TEC_02', N'AI trong y học hiện đại', N'Review công nghệ...', 'images/tec_02.jpg', '2025-02-08', 'tester2', 1540, 'TEC', 0),
('TEST_TEC_03', N'Chip xử lý lượng tử', N'Review công nghệ...', 'images/tec_03.jpg', '2025-03-15', 'tester2', 1230, 'TEC', 1),
('TEST_TEC_04', N'Xe điện tự lái cấp độ 5', N'Review công nghệ...', 'images/tec_04.jpg', '2025-04-22', 'tester2', 1760, 'TEC', 0),
('TEST_TEC_05', N'Mạng 6G thử nghiệm', N'Review công nghệ...', 'images/tec_05.jpg', '2025-05-30', 'tester2', 1880, 'TEC', 1),
('TEST_TEC_06', N'Robot giúp việc gia đình', N'Review công nghệ...', 'images/tec_06.jpg', '2025-06-14', 'tester2', 1120, 'TEC', 0),
('TEST_TEC_07', N'Kính thực tế ảo mới', N'Review công nghệ...', 'images/tec_07.jpg', '2025-07-07', 'tester2', 1350, 'TEC', 1),
('TEST_TEC_08', N'Blockchain trong quản lý', N'Review công nghệ...', 'images/tec_08.jpg', '2025-08-25', 'tester2', 1670, 'TEC', 0),
('TEST_TEC_09', N'Laptop pin 48 giờ', N'Review công nghệ...', 'images/tec_09.jpg', '2025-09-19', 'tester2', 1490, 'TEC', 1),
('TEST_TEC_10', N'Hệ điều hành Windows 12', N'Review công nghệ...', 'images/tec_10.jpg', '2025-10-28', 'tester2', 1910, 'TEC', 0),

-- === 4. THỂ THAO (SPO) ===
('TEST_SPO_01', N'Chung kết bóng đá C1', N'Tin thể thao...', 'images/spo_01.jpg', '2025-01-18', 'tester2', 1010, 'SPO', 1),
('TEST_SPO_02', N'Giải quần vợt mở rộng', N'Tin thể thao...', 'images/spo_02.jpg', '2025-02-14', 'tester2', 1550, 'SPO', 0),
('TEST_SPO_03', N'Marathon xuyên Việt', N'Tin thể thao...', 'images/spo_03.jpg', '2025-03-22', 'tester2', 1820, 'SPO', 1),
('TEST_SPO_04', N'Đua xe F1 tại Hà Nội', N'Tin thể thao...', 'images/spo_04.jpg', '2025-04-30', 'tester2', 1290, 'SPO', 0),
('TEST_SPO_05', N'Tuyển bóng chuyền nữ', N'Tin thể thao...', 'images/spo_05.jpg', '2025-05-18', 'tester2', 1660, 'SPO', 1),
('TEST_SPO_06', N'Kỷ lục bơi lội mới', N'Tin thể thao...', 'images/spo_06.jpg', '2025-06-05', 'tester2', 1940, 'SPO', 0),
('TEST_SPO_07', N'Giải bóng rổ nhà nghề', N'Tin thể thao...', 'images/spo_07.jpg', '2025-07-12', 'tester2', 1180, 'SPO', 1),
('TEST_SPO_08', N'Golf thủ trẻ triển vọng', N'Tin thể thao...', 'images/spo_08.jpg', '2025-08-28', 'tester2', 1390, 'SPO', 0),
('TEST_SPO_09', N'Esports vô địch thế giới', N'Tin thể thao...', 'images/spo_09.jpg', '2025-09-09', 'tester2', 1720, 'SPO', 1),
('TEST_SPO_10', N'Thế vận hội mùa đông', N'Tin thể thao...', 'images/spo_10.jpg', '2025-10-02', 'tester2', 1470, 'SPO', 0),

-- === 5. GIẢI TRÍ (ENT) ===
('TEST_ENT_01', N'Phim bom tấn ra rạp', N'Showbiz...', 'images/ent_01.jpg', '2025-01-25', 'tester2', 1850, 'ENT', 1),
('TEST_ENT_02', N'Show diễn thời trang Thu Đông', N'Showbiz...', 'images/ent_02.jpg', '2025-02-28', 'tester2', 1150, 'ENT', 0),
('TEST_ENT_03', N'Ca sĩ A ra mắt MV mới', N'Showbiz...', 'images/ent_03.jpg', '2025-03-18', 'tester2', 1980, 'ENT', 1),
('TEST_ENT_04', N'Hoa hậu hòa bình quốc tế', N'Showbiz...', 'images/ent_04.jpg', '2025-04-10', 'tester2', 1440, 'ENT', 0),
('TEST_ENT_05', N'Scandal sao hạng A', N'Showbiz...', 'images/ent_05.jpg', '2025-05-05', 'tester2', 1260, 'ENT', 1),
('TEST_ENT_06', N'Liveshow kỷ niệm 20 năm', N'Showbiz...', 'images/ent_06.jpg', '2025-06-20', 'tester2', 1780, 'ENT', 0),
('TEST_ENT_07', N'Game show truyền hình mới', N'Showbiz...', 'images/ent_07.jpg', '2025-07-15', 'tester2', 1030, 'ENT', 1),
('TEST_ENT_08', N'Lễ trao giải Oscar 2025', N'Showbiz...', 'images/ent_08.jpg', '2025-08-08', 'tester2', 1590, 'ENT', 0),
('TEST_ENT_09', N'Triển lãm tranh đương đại', N'Showbiz...', 'images/ent_09.jpg', '2025-09-12', 'tester2', 1370, 'ENT', 1),
('TEST_ENT_10', N'Nhóm nhạc Hàn Quốc đến VN', N'Showbiz...', 'images/ent_10.jpg', '2025-10-30', 'tester2', 1920, 'ENT', 0);
GO