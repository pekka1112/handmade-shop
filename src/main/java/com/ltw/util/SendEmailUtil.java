package com.ltw.util;

import com.sun.mail.util.MailLogger;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Date;
import java.util.Properties;
import java.util.ResourceBundle;

import java.util.UUID;

//pwpa pmnm rjsi manr
public class SendEmailUtil {
    private static final ResourceBundle fromEmailInfo = ResourceBundle.getBundle("fromEmail");

    public static void sendVerificationCode(String toEmail, String verifiedCode) {
        // Email và password của người gửi
        String fromEmail = fromEmailInfo.getString("fromEmail");
        // Sử dụng password của application
        String password = fromEmailInfo.getString("password");

        // Khai bảo các thuộc tính cấu hình gửi mail
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");       // Host: smtp.gmail.com (Gmail)
        properties.put("mail.smtp.port", "587");                 // Port: 587 (TLS)
        properties.put("mail.smtp.auth", "true");               // Authentication: true
        properties.put("mail.smtp.starttls.enable", "true");    // Start TLS: true

        // Tạo ra một Authenticator để đăng nhập vào tài khoản gửi mail
        Authenticator authenticator = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        };

        // Tạo ra phiên làm việc của JavaMail (Khác với Session trong Servlet)
        Session session = Session.getInstance(properties, authenticator);

        // Gửi email
        try {
            Message msg = new MimeMessage(session);
            // Kiểu nội dung
            msg.addHeader("content-type", "text/HTML; charset=UTF-8");
            // Người gửi
            msg.setFrom(new InternetAddress("servicetournest@gmail.com"));
            // Người nhận
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            // Tiêu đề
            msg.setSubject("DDD. - Xác minh tài khoản");
            // Ngày gửi
            msg.setSentDate(new Date());
            // Nội dung
            msg.setContent("<html>" +
                    "<body>" +
                    "<h1 style=\"color: #b07911\">DDD. - Nghệ thuật mỹ nghệ</h1>" +
                    "<hr/>" +
                    "<h3>Mã xác minh của bạn là (Viết hoa):<h3>" +
                    "<h1>" + verifiedCode + "</h1>" +
                    "<p>Vui lòng không tiết lộ mã này cho bất kỳ ai. Trân trọng cảm ơn quý khách đã lựa chọn DDD. - Nghệ thuật mỹ nghệ.</p>" +
                    "<body>" +
                    "</html>", "text/html; charset=utf-8");

            // Gửi nội dung đi
            Transport.send(msg);
            System.out.println("Done!");
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public static void sendVerificationLink(String toEmail, String verifyLink) {
        // Email và password của người gửi
        String fromEmail = fromEmailInfo.getString("fromEmail");
        // Sử dụng password của application
        String password = fromEmailInfo.getString("password");

        // Khai bảo các thuộc tính cấu hình gửi mail
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");       // Host: smtp.gmail.com (Gmail)
        properties.put("mail.smtp.port", "587");                 // Port: 587 (TLS)
        properties.put("mail.smtp.auth", "true");               // Authentication: true
        properties.put("mail.smtp.starttls.enable", "true");    // Start TLS: true

        // Tạo ra một Authenticator để đăng nhập vào tài khoản gửi mail
        Authenticator authenticator = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        };

        // Tạo ra phiên làm việc của JavaMail (Khác với Session trong Servlet)
        Session session = Session.getInstance(properties, authenticator);

        // Gửi email
        try {
            Message msg = new MimeMessage(session);
            // Kiểu nội dung
            msg.addHeader("content-type", "text/HTML; charset=UTF-8");
            // Người gửi
            msg.setFrom(new InternetAddress("servicetournest@gmail.com"));
            // Người nhận
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            // Tiêu đề
            msg.setSubject("DDD. - Xác minh tài khoản");
            // Ngày gửi
            msg.setSentDate(new Date());
            // Nội dung
            msg.setContent("<html>" +
                    "<body>" +
                    "<h1 style=\"color: #b07911\">DDD. - Nghệ thuật mỹ nghệ</h1>" +
                    "<hr/>" +
                    "<h3 style=\"color: black;\">Ấn vào đường link này để tiếp tục lấy lại mật khẩu của bạn: <a href=\"" + verifyLink + "\" style=\"text-decoration: none;\">Xác thực quên mật khẩu</a><h3>" +
                    "<p style=\"font-weight: 500; color: black;\">Trân trọng cảm ơn quý khách đã lựa chọn DDD. - Nghệ thuật mỹ nghệ.</p>" +
                    "<body>" +
                    "</html>", "text/html; charset=utf-8");

            // Gửi nội dung đi
            Transport.send(msg);
            System.out.println("Done!");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    public static void sendOrderNotify(String toEmail, int orderId, String action) {
        // Email và password của người gửi
        String fromEmail = fromEmailInfo.getString("fromEmail");
        // Sử dụng password của application
        String password = fromEmailInfo.getString("password");

        // Khai bảo các thuộc tính cấu hình gửi mail
        Properties properties = new Properties();
        properties.put("mail.smtp.host", "smtp.gmail.com");       // Host: smtp.gmail.com (Gmail)
        properties.put("mail.smtp.port", "587");                 // Port: 587 (TLS)
        properties.put("mail.smtp.auth", "true");               // Authentication: true
        properties.put("mail.smtp.starttls.enable", "true");    // Start TLS: true

        // Tạo ra một Authenticator để đăng nhập vào tài khoản gửi mail
        Authenticator authenticator = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        };

        // Tạo ra phiên làm việc của JavaMail (Khác với Session trong Servlet)
        Session session = Session.getInstance(properties, authenticator);

        // Gửi email
        try {
            Message msg = new MimeMessage(session);
            // Kiểu nội dung
            msg.addHeader("content-type", "text/HTML; charset=UTF-8");
            // Người gửi
            msg.setFrom(new InternetAddress("servicetournest@gmail.com"));
            // Người nhận
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            // Tiêu đề
            msg.setSubject("DDD. - Xác minh tài khoản");
            // Ngày gửi
            msg.setSentDate(new Date());
            // Nội dung
            msg.setContent("<html>" +
                    "<body>" +
                    "<h1 style=\"color: #b07911\">DDD. - Nghệ thuật mỹ nghệ</h1>" +
                    "<hr/>" +
                    "<h3 style=\"color: black;\">DDD. thông báo: Bạn đã order đơn hàng số " + orderId + ", trạng thái hiện tại:" + statusString(action) + "<h3>" +
                    "<p style=\"font-weight: 500; color: black;\">Trân trọng cảm ơn quý khách đã lựa chọn DDD. - Nghệ thuật mỹ nghệ.</p>" +
                    "<body>" +
                    "</html>", "text/html; charset=utf-8");

            // Gửi nội dung đi
            Transport.send(msg);
            System.out.println("Done!");

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }

    private static String statusString(String action) {
        String result = "";
        switch (action) {
            case "wait":
                result = "Chờ xác nhận";
                break;
            case "prepare":
                result = "Đang chuẩn bị hàng";
                break;
            case "deliver":
                result = "Đang giao hàng";
                break;
            case "success":
                result = "Đang chờ xác nhận";
                break;
            case "cancel":
                result = "Đã hủy bỏ";
                break;
        }
        return result;
    }
}
