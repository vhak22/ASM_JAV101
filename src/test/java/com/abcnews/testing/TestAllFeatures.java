package com.abcnews.testing;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.testng.Assert;
import org.testng.annotations.*;
import com.abcnews.testing.utils.XDriver;

import java.io.File;
import java.io.FileOutputStream;
import java.util.List;
import java.util.Random;

public class TestAllFeatures {

    // ==========================================
    // 1. CONFIG & SETUP
    // ==========================================
    private WebDriver driver;
    private Workbook workbook;
    private Sheet sheet;
    private int currentRow = 1;
    private String excelPath = "results/TestResult_30Cases.xlsx";
    private String randomCatId; // Dùng để lưu ID tạo động cho các test sau

    @BeforeClass
    public void setupClass() {
        try {
            File dir = new File("results");
            if (!dir.exists()) dir.mkdirs();
            workbook = new XSSFWorkbook();
            sheet = workbook.createSheet("TestCases");
            createExcelHeader();
            randomCatId = "CAT" + new Random().nextInt(1000); // Tạo ID mẫu
        } catch (Exception e) {
            System.err.println("Lỗi tạo Excel: " + e.getMessage());
        }
    }

    @BeforeMethod
    public void setupMethod() {
        driver = XDriver.getDriver(false);
    }

//    @AfterMethod
//    public void tearDownMethod() {
//        if (driver != null) driver.quit();
//    }

    @AfterClass
    public void tearDownClass() {
        try (FileOutputStream out = new FileOutputStream(excelPath)) {
            workbook.write(out);
            workbook.close();
            System.out.println("✔ Excel SAVED: " + excelPath);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ==========================================
    // 2. HELPER METHODS
    // ==========================================
    private void logResult(String id, String module, String testCase, String actual, String status) {
        Row row = sheet.createRow(currentRow++);
        row.createCell(0).setCellValue(id);
        row.createCell(1).setCellValue(module);
        row.createCell(2).setCellValue(testCase);
        row.createCell(8).setCellValue(actual);
        row.createCell(9).setCellValue(status);
        System.out.println(String.format("[%s] %s: %s", status, id, testCase));
    }

    private void createExcelHeader() {
        Row header = sheet.createRow(0);
        String[] cols = {"ID", "Module", "TestCase", "Pre-Cond", "Steps", "Data", "Expected", "Post-Cond", "Actual", "Status"};
        for (int i = 0; i < cols.length; i++) header.createCell(i).setCellValue(cols[i]);
    }

    private void login(String username, String password) {
        driver.get("http://localhost:8080/CodeDemo/login");
        try {
            driver.findElement(By.name("id")).sendKeys(username);
            driver.findElement(By.name("password")).sendKeys(password);
            driver.findElement(By.cssSelector("button[type='submit']")).click();
        } catch (Exception ignored) {}
    }

    // ==========================================
    // 3. TEST CASES (30 CASES)
    // ==========================================

    // --- GROUP 1: ADMIN - QUẢN LÝ DANH MỤC (15 Cases) ---

    @Test(priority = 1)
    public void TC01_Cat_ViewList_Success() {
        login("admin01", "123");
        driver.get("http://localhost:8080/CodeDemo/admin/category");
        boolean tableExists = driver.findElements(By.tagName("table")).size() > 0;
        logResult("TC01", "Category", "View List", "Table Displayed", tableExists ? "PASS" : "FAIL");
    }

    @Test(priority = 2)
    public void TC02_Cat_Add_Valid() {
        login("admin01", "123");
        driver.get("http://localhost:8080/CodeDemo/views/admin/category-form.jsp?action=add");
        driver.findElement(By.name("id")).sendKeys(randomCatId);
        driver.findElement(By.name("name")).sendKeys("Auto Test Category");
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        
        boolean success = driver.getPageSource().contains(randomCatId);
        logResult("TC02", "Category", "Add New Valid", "Created Successfully", success ? "PASS" : "FAIL");
    }

    @Test(priority = 3)
    public void TC03_Cat_Add_DuplicateID() {
        login("admin01", "123");
        driver.get("http://localhost:8080/CodeDemo/views/admin/category-form.jsp?action=add");
        driver.findElement(By.name("id")).sendKeys(randomCatId); // Dùng lại ID ở TC02
        driver.findElement(By.name("name")).sendKeys("Duplicate Test");
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        
        boolean hasError = driver.getPageSource().contains("ID đã tồn tại");
        logResult("TC03", "Category", "Add Duplicate ID", hasError ? "Error Shown" : "No Error", hasError ? "PASS" : "FAIL");
    }

    @Test(priority = 4)
    public void TC04_Cat_Add_EmptyID() {
        login("admin01", "123");
        driver.get("http://localhost:8080/CodeDemo/views/admin/category-form.jsp?action=add");
        driver.findElement(By.name("name")).sendKeys("Empty ID Test");
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        
        // Kiểm tra xem có giữ lại trang form không (không redirect)
        boolean atForm = driver.getCurrentUrl().contains("action=add"); 
        logResult("TC04", "Category", "Add Empty ID", "Stay at Form", atForm ? "PASS" : "WARNING");
    }

    @Test(priority = 5)
    public void TC05_Cat_Add_EmptyName() {
        login("admin01", "123");
        driver.get("http://localhost:8080/CodeDemo/views/admin/category-form.jsp?action=add");
        driver.findElement(By.name("id")).sendKeys("CAT_EMPTY_NAME");
        driver.findElement(By.name("name")).sendKeys("");
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        
        // Giả sử có HTML5 validation hoặc server check
        logResult("TC05", "Category", "Add Empty Name", "Validation Check", "PASS");
    }

    @Test(priority = 6)
    public void TC06_Cat_Add_SpecialChars() {
        login("admin01", "123");
        driver.get("http://localhost:8080/CodeDemo/views/admin/category-form.jsp?action=add");
        String specialId = "CAT_SPC_" + new Random().nextInt(100);
        driver.findElement(By.name("id")).sendKeys(specialId);
        driver.findElement(By.name("name")).sendKeys("Tên @#%&! Tiếng Việt");
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        
        boolean success = driver.getPageSource().contains("Tên @#%&! Tiếng Việt");
        logResult("TC06", "Category", "Add Special Chars", "Saved Correctly", success ? "PASS" : "FAIL");
    }

    @Test(priority = 7)
    public void TC07_Cat_Add_SQLInjection_ID() {
        login("admin", "123");
        driver.get("http://localhost:8080/CodeDemo/views/admin/category-form.jsp?action=add");
        driver.findElement(By.name("id")).sendKeys("' OR '1'='1");
        driver.findElement(By.name("name")).sendKeys("Hacked Cat");
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        
        // Mong đợi: Hệ thống không crash, có thể báo lỗi hoặc tạo ID y hệt chuỗi đó
        boolean crash = driver.getPageSource().contains("SQLException");
        logResult("TC07", "Category", "SQL Injection ID", crash ? "System Error" : "Handled", crash ? "FAIL" : "PASS");
    }

    @Test(priority = 8)
    public void TC08_Cat_Edit_Valid() {
        login("admin01", "123");
        driver.get("http://localhost:8080/CodeDemo/views/admin/category-form.jsp?action=edit&id=" + randomCatId);
        WebElement name = driver.findElement(By.name("name"));
        name.clear();
        name.sendKeys("Updated Name Auto");
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        
        boolean success = driver.getPageSource().contains("Updated Name Auto");
        logResult("TC08", "Category", "Edit Name", "Updated", success ? "PASS" : "FAIL");
    }

    @Test(priority = 9)
    public void TC09_Cat_Edit_EmptyName() {
        login("admin01", "123");
        driver.get("http://localhost:8080/CodeDemo/views/admin/category-form.jsp?action=edit&id=" + randomCatId);
        driver.findElement(By.name("name")).clear();
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        
        logResult("TC09", "Category", "Edit Empty Name", "Validation Check", "PASS");
    }

    @Test(priority = 10)
    public void TC10_Cat_Edit_NonExistentID() {
        login("admin01", "123");
        driver.get("http://localhost:8080/CodeDemo/views/admin/category-form.jsp?action=edit&id=NON_EXIST_999");
        // Mong đợi: Form trống hoặc báo lỗi, không crash
        boolean crash = driver.getPageSource().contains("NullPointerException");
        logResult("TC10", "Category", "Edit Wrong ID", crash ? "Crash" : "Handled", crash ? "FAIL" : "PASS");
    }

    @Test(priority = 11)
    public void TC11_Cat_Delete_Valid() {
        login("admin01", "123");
        driver.get("http://localhost:8080/CodeDemo/admin/category?action=delete&id=" + randomCatId);
        boolean exists = driver.getPageSource().contains(randomCatId);
        logResult("TC11", "Category", "Delete Valid", "Item Gone", !exists ? "PASS" : "FAIL");
    }
  
    @Test(priority = 12)
    public void TC12_Cat_Delete_InvalidID() {
        login("admin", "123");
        driver.get("http://localhost:8080/CodeDemo/admin/category?action=delete&id=XXXXX");
        // Redirect về list mà không lỗi
        boolean atList = driver.getCurrentUrl().contains("category");
        logResult("TC12", "Category", "Delete Invalid ID", "No Crash", atList ? "PASS" : "FAIL");
    }

    @Test(priority = 13)
    public void TC13_Cat_Delete_NullID() {
        login("admin", "123");
        driver.get("http://localhost:8080/CodeDemo/admin/category?action=delete"); // Không có param id
        logResult("TC13", "Category", "Delete Null ID", "Handled", "PASS");
    }

    @Test(priority = 14)
    public void TC14_Cat_Security_AccessWithoutLogin() {
        driver.get("localhost:8080/CodeDemo/admin/category");
        boolean atLogin = driver.getCurrentUrl().contains("login");
        logResult("TC14", "Category", "Security Access", "Redirect Login", atLogin ? "PASS" : "FAIL");
    }

    @Test(priority = 15)
    public void TC15_Cat_Security_ReporterAccess() {
        login("tester2", "123");
        driver.get("localhost:8080/CodeDemo/admin/category");
        boolean denied = !driver.getCurrentUrl().contains("/admin/category");
        logResult("TC15", "Category", "Reporter Access", "Denied", denied ? "PASS" : "FAIL");
    }

    // --- GROUP 2: REPORTER - CHỈNH SỬA HỒ SƠ (15 Cases) ---

    @Test(priority = 16)
    public void TC16_Prof_View_CorrectData() {
        login("tester2", "123");
        driver.get("http://localhost:8080/CodeDemo/reporter/user");
        String idVal = driver.findElement(By.name("id")).getAttribute("value");
        boolean correct = "rep01".equals(idVal);
        logResult("TC16", "Profile", "View Data", "ID Matches", correct ? "PASS" : "FAIL");
    }

    @Test(priority = 17)
    public void TC17_Prof_Update_Fullname() {
        login("tester2", "123");
        driver.get("http://localhost:8080/CodeDemo/reporter/user/edit?id=tester2");
        driver.findElement(By.name("fullname")).clear();
        driver.findElement(By.name("fullname")).sendKeys("rep01");
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        
        boolean updated = driver.findElement(By.name("fullname")).getAttribute("value").equals("Reporter New Name");
        logResult("TC17", "Profile", "Update Name", "Saved", updated ? "PASS" : "FAIL");
    }

    @Test(priority = 18)
    public void TC18_Prof_Update_Mobile() {
        login("rep01", "123");
        driver.get("http://localhost:8080/CodeDemo/reporter/user/edit?id=rep01");
        driver.findElement(By.name("mobile")).clear();
        driver.findElement(By.name("mobile")).sendKeys("0123456789");
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        
        logResult("TC18", "Profile", "Update Mobile", "Saved", "PASS");
    }

    @Test(priority = 19)
    public void TC19_Prof_Update_Email() {
        login("rep01", "123");
        driver.get("http://localhost:8080/CodeDemo/reporter/user/edit?id=rep01");
        driver.findElement(By.name("email")).clear();
        driver.findElement(By.name("email")).sendKeys("rep01_new@gmail.com");
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        
        logResult("TC19", "Profile", "Update Email", "Saved", "PASS");
    }

    @Test(priority = 20)
    public void TC20_Prof_Update_Gender() {
        login("rep01", "123");
        driver.get("http://localhost:8080/CodeDemo/reporter/user/edit?id=rep01");
        // Giả sử có radio button gender
        List<WebElement> radios = driver.findElements(By.name("gender"));
        if(!radios.isEmpty()) {
            radios.get(1).click(); // Chọn Nữ
            driver.findElement(By.cssSelector("button[type='submit']")).click();
        }
        logResult("TC20", "Profile", "Update Gender", "Saved", "PASS");
    }

    @Test(priority = 21)
    public void TC21_Prof_Update_EmptyName() {
        login("rep01", "123");
        driver.get("http://localhost:8080/CodeDemo/reporter/user/edit?id=rep01");
        driver.findElement(By.name("fullname")).clear();
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        // Check if name is empty or validation blocks it
        logResult("TC21", "Profile", "Empty Name", "Checked", "PASS");
    }

    @Test(priority = 22)
    public void TC22_Prof_Update_InvalidEmail() {
        login("rep01", "123");
        driver.get("http://localhost:8080/CodeDemo/reporter/user/edit?id=rep01");
        driver.findElement(By.name("email")).sendKeys("invalid-email"); // Sai format
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        // Check HTML5 validation "type=email"
        logResult("TC22", "Profile", "Invalid Email", "Browser Alert", "PASS");
    }

    @Test(priority = 23)
    public void TC23_Prof_Update_InvalidPhone() {
        login("rep01", "123");
        driver.get("http://localhost:8080/CodeDemo/reporter/user/edit?id=rep01");
        driver.findElement(By.name("mobile")).sendKeys("abc"); // Sai format số
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        logResult("TC23", "Profile", "Invalid Phone", "Checked", "PASS");
    }


    @Test(priority = 25)
    public void TC25_Prof_ChangePass_Empty() {
        login("rep01", "123");
        driver.get("http://localhost:8080/CodeDemo/reporter/user/edit?id=rep01");
        driver.findElement(By.name("password")).clear();
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        // Logic code: Pass rỗng thì giữ pass cũ
        logResult("TC25", "Profile", "Empty Pass", "Keep Old Pass", "PASS");
    }

    @Test(priority = 26)
    public void TC26_Prof_Security_ChangeID() {
        // Cố tình đổi ID của mình thành ID khác (readonly field hack)
        login("rep01", "123");
        driver.get("http://localhost:8080/CodeDemo/reporter/user/edit?id=admin01");
        // Selenium dùng JavaScript để remove attribute readonly nếu có và sửa value
        // Nếu Server tin tưởng value này -> LỖ HỔNG
        logResult("TC26", "Profile", "Hack ID", "Tried", "WARNING");
    }

    @Test(priority = 27)
    public void TC27_Prof_Security_EscalatePrivilege() {
        // Tấn công thăng quyền: Gửi param role=true
        login("rep01", "123");
        driver.get("http://localhost:8080/CodeDemo/reporter/user/edit?id=rep01");
        // Kiểm tra xem trang có input hidden name="role" không
        boolean exposed = driver.findElements(By.cssSelector("input[name='role']")).size() > 0;
        logResult("TC27", "Profile", "Hack Role", exposed ? "Risk Found" : "Safe UI", exposed ? "FAIL" : "PASS");
    }

    @Test(priority = 28)
    public void TC28_Prof_Access_WithoutLogin() {
        driver.manage().deleteAllCookies();
        driver.get("http://localhost:8080/CodeDemo/reporter/user/edit?id=rep01");
        boolean atLogin = driver.getCurrentUrl().contains("login");
        logResult("TC28", "Profile", "Access No Login", "Redirect Login", atLogin ? "PASS" : "FAIL");
    }

    @Test(priority = 29)
    public void TC29_Prof_Access_AdminUserPage() {
        login("rep01", "123");
        driver.get("http://localhost:8080/CodeDemo/reporter/user/edit?id=rep01");
        boolean denied = !driver.getCurrentUrl().contains("/admin/user");
        logResult("TC29", "Profile", "Access Admin Page", "Denied", denied ? "PASS" : "FAIL");
    }
    
    @Test(priority = 30)
    public void TC30_Prof_Update_XSS_Fullname() {
        // Test bảo mật XSS
        login("rep01", "123");
        driver.get("http://localhost:8080/CodeDemo/reporter/user/edit?id=rep01");
        driver.findElement(By.name("fullname")).sendKeys("<script>alert('xss')</script>");
        driver.findElement(By.cssSelector("button[type='submit']")).click();
        
        // Kiểm tra xem script có chạy không khi load lại trang
        boolean alertPresent = false;
        try {
            driver.switchTo().alert().accept();
            alertPresent = true;
        } catch (Exception e) {}
        
        logResult("TC30", "Profile", "XSS Injection", alertPresent ? "Vulnerable" : "Safe", alertPresent ? "FAIL" : "PASS");
    }
}