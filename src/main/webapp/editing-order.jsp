<%@ page import="com.ltw.bean.OrderBean" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>DDD. Admin - Thêm tài khoản</title>

    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/all.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-solid.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-regular.css">
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.4.2/css/sharp-light.css">

    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="<c:url value="/templates/admin/css/styles.css"/>">
    <link rel="stylesheet" href="<c:url value="/templates/admin/css/admin-custom.css"/>">
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
<jsp:include page="/common/admin/top-header.jsp"/>
<div id="layoutSidenav">
    <jsp:include page="/common/admin/left-navigation.jsp"/>
    <div id="layoutSidenav_content" class="gray-bg">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Chỉnh sửa đơn hàng</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item active">DDD. Administrator</li>
                </ol>
                <%
                    OrderBean orderBean = (OrderBean) request.getAttribute("orderBean");
                    String success = request.getParameter("success");
                %>
                <% if (success != null) { %>
                <div class="alert alert-success">
                    Chỉnh sửa đơn hàng thành công!
                </div>
                <% } %>
                <form action="<c:url value="/admin/order-management/editing"/>" method="post">
                    <div class="row">
                        <div class="col-6">
                            <label for="email"></label>
                            <input type="text" id="email" name="email" value="<%=orderBean.getId()%>" disabled>
                        </div>

                        <div class="col-3">
                            <label for="createdDate">Ngày đặt</label>
                            <input type="text" id="createdDate" name="createdDate" value="<%=orderBean.getCreatedDate()%>" disabled>
                        </div>

                        <div class="col-3">
                            <label for="shipToDate">Ngày giao</label>
                            <input type="text" id="shipToDate" name="shipToDate" value="<%=orderBean.getShipToDate()%>" disabled>
                        </div>

                        <div class="col-6">
                            <label for="total">Tổng trị giá</label>
                            <input type="email" id="total" name="total" value="<fmt:formatNumber value="<%=orderBean.getTotal()%>" pattern="#,##0.0"/>đ" disabled>
                        </div>

                        <div class="col-6">
                            <label for="status">Trạng thái</label>
                            <select type="text" id="status" name="status">
                                <option value="1" <%= (orderBean.getStatus() == 1) ? "selected" : "" %>>Chờ xác nhận</option>
                                <option value="2" <%= (orderBean.getStatus() == 2) ? "selected" : "" %>>Đã xác nhận</option>
                                <option value="3" <%= (orderBean.getStatus() == 3) ? "selected" : "" %>>Đang vận chuyển</option>
                                <option value="4" <%= (orderBean.getStatus() == 4) ? "selected" : "" %>>Thành công</option>
                                <option value="0" <%= (orderBean.getStatus() == 0) ? "selected" : "" %>>Hủy bỏ</option>
                            </select>
                        </div>
                    </div>
                    <input type="hidden" name="id" value="<%=orderBean.getId()%>">

                    <input type="submit" value="Chỉnh sửa đơn hàng" class="adding button">
                    <a href="<c:url value="/admin/order-management"/>">Quay về trang quản lý</a>
                    <a href="<c:url value="/admin/home"/>">Quay về trang chủ</a>
                </form>
            </div>
        </main>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="<c:url value="/templates/admin/js/scripts.js"/>"></script>
</body>
</html>
