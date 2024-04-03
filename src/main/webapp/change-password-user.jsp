<%@ page import="com.ltw.bean.UserBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="shortcut icon" href="../favicon.png">

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

    <!-- Bootstrap CSS -->
    <link href="<c:url value="/templates/client/css/bootstrap.min.css"/>" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="<c:url value="/templates/client/css/tiny-slider.css"/>" rel="stylesheet">
    <link href="<c:url value="/templates/client/css/style.css"/>" rel="stylesheet">

    <title>DDD. - Nghệ thuật mỹ nghệ</title>
</head>

<body>
<jsp:include page="/common/client/header.jsp"/>
<!-- Start Hero Section -->
<div class="hero home position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-12">
                <div class="intro-excerpt">
                    <h1>Đặt mật khẩu mới</h1>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Hero Section -->

<!-- Start Renew Password -->
<div class="renew-password position-relative-top-84px">
    <div class="container">
        <div class="contain-form p-4">
            <div class="dp-flex flex-column justify-content-center">
                <%
                    UserBean user = (UserBean) request.getSession().getAttribute("user");
                %>
                <div class="renew-password-title">
                    <h3>Đặt mật khẩu mới</h3>
                </div>
                <form action="<c:url value="/change-password-user"/>" method="post" id="renewPwForm">
                    <div class="password">
                        <label for="oldPassword">Mật khẩu cũ</label>
                        <input type="password" name="oldPassword" id="oldPassword" oninput="renewPassword()">
                    </div>
                    <div id="oldpw-error"></div>

                    <div class="password">
                        <label for="newPassword">Mật khẩu mới</label>
                        <input type="password" name="newPassword" id="newPassword" oninput="renewPassword()">
                    </div>
                    <div id="newpw-error"></div>

                    <div class="password">
                        <label for="retypePassword">Nhập lại mật khẩu</label>
                        <input type="password" name="retypePassword" id="retypePassword" oninput="renewPassword()">
                    </div>
                    <div id="retype-error"></div>
                    <input type="hidden" name="email" value="<%=user.getEmail()%>">
                    <input type="submit" value="Thay đổi mật khẩu">
                </form>
                <div class="dp-flex justify-content-between renew-button-group">
                    <a href="<c:url value="/home"/>" class="passwd-button a-btn">Quay lại trang chủ</a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Renew Password -->

<!-- Start Footer Section -->
<footer class="footer-section position-relative-top-84px">
    <div class="container relative">
        <div class="row g-5 mb-5">
            <div class="col-4">
                <div class="mb-4"><p href="#" class="footer-head">DDD<span>.</span></p></div>
                <p class="mb-4 light-text footer-content">Với chúng tôi, mỗi một sản phẩm mỹ nghệ đều là một kiệt tác, là một tác phẩm nghệ thuật. Cảm ơn bạn đã ghé thăm DDD. - Nghệ thuật mỹ nghệ. Mua sắm với chúng tôi trong mục sản phẩm, hoặc bấm vào nút Khám phá trên trang chủ.</p>
            </div>

            <div class="col-4 center-text">
                <div class="mb-4"><p id="mxh-changing" class="footer-head">Mạng xã hội</p></div>
                <p class="mb-4 light-text footer-content">Đừng quên theo dõi chúng tôi qua các kênh mạng xã hội sau để không bỏ lỡ nhưng thông tin mới nhất của DDD. - Nghệ thuật mỹ nghệ</p>
                <ul class="list-unstyled custom-social">
                    <li><a href="#"><span class="fa fa-brands fa-facebook-f footer-content"></span></a></li>
                    <li><a href="#"><span class="fa fa-brands fa-twitter footer-content"></span></a></li>
                    <li><a href="#"><span class="fa fa-brands fa-instagram footer-content"></span></a></li>
                    <li><a href="#"><span class="fa fa-brands fa-linkedin footer-content"></span></a></li>
                </ul>
            </div>

            <div class="col-4">
                <div class="row links-wrap">
                    <div class="right-text">
                        <div class="mb-4"><p class="footer-head">Nội dung</p></div>
                        <ul class="list-unstyled ">
                            <li><a class="light-text footer-content" href="#">Sản phẩm</a></li>
                            <li><a class="light-text footer-content" href="#">Tin tức</a></li>
                            <li><a class="light-text footer-content" href="#">Liên hệ</a></li>
                            <li><a class="light-text footer-content" href="#">Về chúng tôi</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="border-top copyright">
            <div class="row pt-4">
                <div class="col-lg-6">
                    <p class="mb-2 text-center text-lg-start light-text footer-content">Copyright &copy;<script>document.write(new Date().getFullYear());</script>. All Rights Reserved.</p>
                    <!-- License information: https://untree.co/license/ -->
                </div>

                <div class="col-lg-6 text-center text-lg-end light-text">
                    <ul class="list-unstyled d-inline-flex ms-auto">
                        <li class="me-4 footer-content"><a  href="#">Terms &amp; Conditions</a></li>
                        <li><a href="#" class="footer-content">Privacy Policy</a></li>
                    </ul>
                </div>
            </div>
        </div>

    </div>
</footer>
<!-- End Footer Section -->

<button id="scroll-to-top"><i class="fa-solid fa-chevron-up" style="color: #e3bd74;"></i></button>

<script src="<c:url value="/templates/client/js/bootstrap.bundle.min.js"/>"></script>
<script src="<c:url value="/templates/client/js/tiny-slider.js"/>"></script>
<script src="<c:url value="/templates/client/js/custom.js"/>"></script>
</body>
</html>
