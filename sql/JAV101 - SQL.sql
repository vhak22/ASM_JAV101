-- Chỉnh tên database nếu cần
CREATE DATABASE JAV101;
go
USE JAV101;
GO

-- =========================
-- Bảng Categories
-- =========================
CREATE TABLE dbo.Categories (
    Id   NVARCHAR(50)  NOT NULL,
    Name NVARCHAR(200) NOT NULL,
    CONSTRAINT PK_Categories PRIMARY KEY (Id)
);
GO

-- =========================
-- Bảng Users
-- =========================
CREATE TABLE dbo.Users (
    Id        NVARCHAR(50)  NOT NULL,        -- mã đăng nhập
    Password  NVARCHAR(256) NOT NULL,        -- lưu hash mật khẩu
    Fullname  NVARCHAR(200) NULL,
    Birthday  DATE         NULL,
    Gender    BIT          NULL,             -- 1 = Male, 0 = Female (theo yêu cầu có Boolean)
    Mobile    NVARCHAR(50) NULL,
    Email     NVARCHAR(320) NULL,
    Role      BIT          NOT NULL DEFAULT 0, -- 1 = Admin, 0 = Reporter
    CreatedAt DATETIME     NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Users PRIMARY KEY (Id)
);
GO

-- Tùy chọn: đảm bảo email user là duy nhất nếu không NULL
CREATE UNIQUE INDEX UX_Users_Email ON dbo.Users(Email) WHERE Email IS NOT NULL;
GO

-- =========================
-- Bảng News
-- =========================
CREATE TABLE dbo.News (
    Id         NVARCHAR(50)  NOT NULL,
    Title      NVARCHAR(500) NOT NULL,
    Content    NVARCHAR(MAX) NULL,
    Image      NVARCHAR(500) NULL,           -- đường dẫn ảnh/video
    PostedDate DATETIME      NOT NULL DEFAULT GETDATE(),
    Author     NVARCHAR(50)  NOT NULL,       -- FK -> Users.Id
    ViewCount  INT           NOT NULL DEFAULT 0,
    CategoryId NVARCHAR(50)  NOT NULL,       -- FK -> Categories.Id
    Home       BIT           NOT NULL DEFAULT 0,
    IsActive   BIT           NOT NULL DEFAULT 1,
    CreatedAt  DATETIME      NOT NULL DEFAULT GETDATE(),
    UpdatedAt  DATETIME      NULL,
    CONSTRAINT PK_News PRIMARY KEY (Id)
);
GO

-- Thêm khóa ngoại cho News
ALTER TABLE dbo.News
    ADD CONSTRAINT FK_News_Author FOREIGN KEY (Author) REFERENCES dbo.Users(Id) ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

ALTER TABLE dbo.News
    ADD CONSTRAINT FK_News_Category FOREIGN KEY (CategoryId) REFERENCES dbo.Categories(Id) ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

-- =========================
-- Bảng Newsletters
-- =========================
CREATE TABLE dbo.Newsletters (
    Email        NVARCHAR(320) NOT NULL,
    Enabled      BIT           NOT NULL DEFAULT 1,
    SubscribedAt DATETIME      NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Newsletters PRIMARY KEY (Email)
);
GO

-- =========================
-- Dữ liệu mẫu - Categories
-- =========================
INSERT INTO dbo.Categories (Id, Name) VALUES
('CAT001', N'Thời sự'),
('CAT002', N'Văn hóa'),
('CAT003', N'Thể thao'),
('CAT004', N'Pháp luật'),
('CAT005', N'Kinh doanh');
GO

-- =========================
-- Dữ liệu mẫu - Users
-- Ghi chú: Password ở đây chỉ ví dụ; thực tế lưu hash an toàn.
-- =========================
INSERT INTO dbo.Users (Id, Password, Fullname, Birthday, Gender, Mobile, Email, Role)
VALUES
('admin',    N'$2a$10$exampleAdminHash', N'Nguyễn Văn Quản', '1985-01-15', 1, N'0901000100', N'admin@abcnews.local', 1),
('rep001',   N'$2a$10$exampleRep1Hash',  N'Phạm Văn A',      '1992-05-10', 1, N'0902000200', N'rep1@abcnews.local', 0),
('rep002',   N'$2a$10$exampleRep2Hash',  N'Lê Thị B',        '1993-07-20', 0, N'0903000300', N'rep2@abcnews.local', 0),
('rep003',   N'$2a$10$exampleRep3Hash',  N'Trần Văn C',      '1990-03-30', 1, N'0904000400', N'rep3@abcnews.local', 0);
GO

-- =========================
-- Dữ liệu mẫu - News
-- =========================
INSERT INTO dbo.News (Id, Title, Content, Image, PostedDate, Author, ViewCount, CategoryId, Home, IsActive)
VALUES
('NEWS001', N'Chính: Sự kiện thời sự nổi bật hôm nay', N'Đoạn mở đầu nội dung tin 1...', N'/uploads/news/news001.jpg', DATEADD(hour,-5,GETDATE()), 'rep001', 120, 'CAT001', 1, 1),
('NEWS002', N'Văn hóa: Liên hoan nghệ thuật địa phương',   N'Đoạn mở đầu nội dung tin 2...', N'/uploads/news/news002.jpg', DATEADD(day,-1,GETDATE()),    'rep002', 45, 'CAT002', 0, 1),
('NEWS003', N'Thể thao: Đội tuyển giành chiến thắng',      N'Đoạn mở đầu nội dung tin 3...', N'/uploads/news/news003.jpg', DATEADD(day,-2,GETDATE()),    'rep003', 200, 'CAT003', 1, 1),
('NEWS004', N'Pháp luật: Vụ án nổi cộm trong tuần',        N'Đoạn mở đầu nội dung tin 4...', N'/uploads/news/news004.jpg', DATEADD(day,-3,GETDATE()),    'rep001', 30, 'CAT004', 0, 1),
('NEWS005', N'Kinh doanh: Thị trường biến động',          N'Đoạn mở đầu nội dung tin 5...', N'/uploads/news/news005.jpg', DATEADD(day,-7,GETDATE()),    'rep002', 75, 'CAT005', 0, 1),
('NEWS006', N'Pháp luật: Tin tức bổ sung',                N'Nội dung chi tiết bản tin 6...', N'/uploads/news/news006.jpg', DATEADD(hour,-2,GETDATE()), 'rep003', 5,  'CAT004', 0, 1);
GO

-- =========================
-- Dữ liệu mẫu - Newsletters
-- =========================
INSERT INTO dbo.Newsletters (Email, Enabled, SubscribedAt) VALUES
('reader1@example.com', 1, DATEADD(day,-10,GETDATE())),
('reader2@example.com', 1, DATEADD(day,-5,GETDATE())),
('reader3@example.com', 0, DATEADD(day,-30,GETDATE())); -- ví dụ đã hủy
GO

-- Thông báo hoàn tất
PRINT 'Tạo bảng và chèn dữ liệu mẫu hoàn tất.';
SELECT * FROM Newsletters;



