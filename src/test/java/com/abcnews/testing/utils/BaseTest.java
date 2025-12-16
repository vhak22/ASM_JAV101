package com.abcnews.testing.utils;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.openqa.selenium.WebDriver;
import org.testng.annotations.*;
import com.abcnews.testing.utils.XDriver;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

public class BaseTest {

    // --- Khai báo biến cho Excel ---
    private Workbook workbook;
    private Sheet sheet;
    private int currentRow = 1; // Dòng bắt đầu ghi data (dòng 0 là header)
    private String excelPath;

    // =======================
    // 1. SETUP (BEFORE SUITE)
    // =======================
    @BeforeSuite
    @Parameters({"testType"})
    public void beforeSuite(@Optional("Login") String testType) {
        try {
            // A. Thiết lập đường dẫn file
            File dir = new File("results");
            if (!dir.exists()) dir.mkdirs();
            excelPath = "results/TestResults_" + testType + ".xlsx";

            // B. Khởi tạo Workbook và Sheet
            workbook = new XSSFWorkbook();
            sheet = workbook.createSheet("TestCases");

            // C. Tạo Header cho Excel
            createExcelHeader();

            System.out.println("✔ TestSuite STARTED -> Excel created at: " + excelPath);
        } catch (Exception e) {
            System.out.println("❌ ERROR initializing Excel: " + e.getMessage());
        }
    }

    // =======================
    // 2. TEARDOWN (AFTER SUITE)
    // =======================
    @AfterSuite(alwaysRun = true)
    public void afterSuite() {
        // A. Lưu file Excel
        try (FileOutputStream out = new FileOutputStream(excelPath)) {
            workbook.write(out);
            workbook.close();
            System.out.println("✔ Excel SAVED successfully → " + excelPath);
        } catch (IOException e) {
            System.out.println("❌ ERROR saving Excel: " + e.getMessage());
        }

        // B. Đóng trình duyệt
        try {
            XDriver.quitDriver();
            System.out.println("✔ Browser CLOSED");
        } catch (Exception ignored) {}
    }

    // =======================
    // 3. HÀM GHI KẾT QUẢ (Thay thế ExcelHelper)
    // =======================
    protected void logResult(
            String testCaseId, String testScenario, String testCase,
            String preCondition, String testSteps, String testData,
            String expectedResult, String postCondition, String actualResult, String status
    ) {
        Row row = sheet.createRow(currentRow++);
        CellStyle style = createBorderStyle();

        String[] values = {
            testCaseId, testScenario, testCase, preCondition,
            testSteps, testData, expectedResult, postCondition,
            actualResult, status
        };

        for (int i = 0; i < values.length; i++) {
            Cell cell = row.createCell(i);
            cell.setCellValue(values[i]);
            cell.setCellStyle(style);
            // Auto size column (lưu ý: có thể làm chậm nếu dữ liệu lớn, có thể bỏ qua nếu muốn nhanh)
             sheet.autoSizeColumn(i); 
        }
    }

    // =======================
    // 4. CÁC HÀM HỖ TRỢ (PRIVATE HELPERS)
    // =======================
    private void createExcelHeader() {
        String[] cols = {
            "TEST CASE ID", "TEST SCENARIO", "TEST CASE", "PRE-CONDITION",
            "TEST STEPS", "TEST DATA", "EXPECTED RESULT", "POST CONDITION",
            "ACTUAL RESULT", "STATUS (PASS/FAIL)"
        };

        Row header = sheet.createRow(0);
        CellStyle style = createBorderStyle();
        Font font = workbook.createFont();
        font.setBold(true);
        style.setFont(font);

        for (int i = 0; i < cols.length; i++) {
            Cell cell = header.createCell(i);
            cell.setCellValue(cols[i]);
            cell.setCellStyle(style);
            sheet.autoSizeColumn(i);
        }
    }

    private CellStyle createBorderStyle() {
        CellStyle style = workbook.createCellStyle();
        style.setBorderBottom(BorderStyle.THIN);
        style.setBorderTop(BorderStyle.THIN);
        style.setBorderLeft(BorderStyle.THIN);
        style.setBorderRight(BorderStyle.THIN);
        return style;
    }

    // =======================
    // 5. SELENIUM UTILS (Dùng chung)
    // =======================
    protected void pause(long millis) {
        try { Thread.sleep(millis); } catch (InterruptedException ignored) {}
    }

    protected void loginAs(String id, String password) {
        try {
            WebDriver driver = XDriver.getDriver(false);
            driver.get("http://localhost:8080/CodeDemo/login");
            pause(800);

            try { driver.findElement(org.openqa.selenium.By.name("id")).clear(); } catch (Exception ignored) {}
            driver.findElement(org.openqa.selenium.By.name("id")).sendKeys(id);

            try { driver.findElement(org.openqa.selenium.By.name("password")).clear(); } catch (Exception ignored) {}
            driver.findElement(org.openqa.selenium.By.name("password")).sendKeys(password);

            driver.findElement(org.openqa.selenium.By.className("btn-login")).click();
            pause(1200);
        } catch (Exception e) {
            System.out.println("Login failed: " + e.getMessage());
        }
    }
}