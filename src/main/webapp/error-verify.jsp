<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"><style data-styles="">ion-icon{visibility:hidden}.hydrated{visibility:inherit}</style>
    <title>Quên mật khẩu</title>
    <script type="module" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule="" src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap">
    <link rel="stylesheet" href="<c:url value="/templates/login-signup-forget/forget/css/QuenMatKhau.css"/>">

</head>
<style>
    .error-message {
        color: red;
        font-size: 80%;
    }
</style>
<body>
<div class="screen-1">
    <div class="logo">
        <h1>DDD.</h1>
    </div>
    <div class="header">
        <h2>Quên mật khẩu</h2>
    </div>
    <div class="checking">
        Đường link này không hợp lệ! Hãy kiểm tra lại!
    </div>
    <div class="back-home">
        <a href="<c:url value="/home"/>" class="link">Trở lại trang chủ</a>
    </div>
</div>
<script src="<c:url value="/templates/login-signup-forget/forget/js/QuenMatKhau.js"/>"></script>
</body>
</html>