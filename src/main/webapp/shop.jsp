<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.CategoryBean" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.ltw.bean.CategoryTypeBean" %>
<%@ page import="com.ltw.bean.ProductBean" %>
<%@ page import="com.ltw.bean.ProductImageBean" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
<style>
    #search_bar {
        border-top-left-radius: 20px !important;
        border-bottom-left-radius: 20px !important;
        font-size: 25px;
        transition: font-size 0.3s ease; /* Thêm chuyển tiếp mượt mà */
    }
    #search_bar:focus {
        font-size: 25px; /* Kích thước chữ lớn hơn khi focus */
    }
    #search_bar::placeholder {
        font-size: 20px; /* Đặt kích thước cho placeholder */
    }
    #search_btn {
        width: 150px;
        background-color: #2a1710;
        border-top-right-radius: 20px !important;
        border-bottom-right-radius: 20px  !important;
    }
    #search_btn i {
        font-size: 25px;
        color: #e3bd74;
    }
</style>

<body>
<jsp:include page="/common/client/header.jsp"/>
<!-- Start Hero Section -->
<div class="hero shop position-relative-top-84px">
    <div class="container">
        <div class="row justify-content-between">
            <div class="col-12">
                <div class="intro-excerpt">
                    <h1>Sản phẩm</h1>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- End Hero Section -->


<!-- Start Shop Section -->
<div class="product-section product-section before-footer-section position-relative-top-50px">
    <div class="container">
        <div class="row mb-3">
            <form action="<c:url value="/search"/>" method="get">
                <input type="hidden" name="sort" value="none">
                <input type="hidden" name="range" value="none">
                <input type="hidden" name="page" value="1">
                <div class="input-group" >
                    <%-- Ô tìm kiếm --%>
                    <input type="text" class="form-control rounded" id="search_bar" placeholder="Nhập từ khóa để tìm kiếm sản phẩm"
                           style=" border-top-left-radius: 20px !important;border-bottom-left-radius: 20px !important"
                           aria-label="Search" aria-describedby="search-addon" name="key"/>
                    <%-- Nút tìm kiếm --%>
                    <button type="submit" class="btn btn-outline-primary" id="search_btn"  style="width: 150px; background-color: #2a1710; border-top-right-radius: 20px !important;  border-bottom-right-radius: 20px  !important  " data-mdb-ripple-init>
                        <i style="font-size: 25px ; color: #e3bd74" class="fa-solid fa-magnifying-glass" ></i>
                    </button>
                </div>
            </form>
        </div>

        <%
            String success = request.getParameter("success");
            if (success != null) {
        %>
        <div class="alert alert-success alert-dismissible fade show" role="alert" id="autoDismissAlert">
            Thêm sản phẩm thành công!
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <% } %>
        <div class="row">
            <div class="col-3 pe-3 nav-left">
                <div class="nav-left-block mb-5">
                    <p class="nav-left-title">Danh mục sản phẩm</p>
                    <%
                        List<CategoryBean> categories = (List<CategoryBean>) request.getAttribute("categories");
                        Map<Integer, List<CategoryTypeBean>> categoryTypeMap = (Map<Integer, List<CategoryTypeBean>>) request.getAttribute("categoryTypeMap");
                    %>
                    <ul class="nav-left-list">
                        <% for (CategoryBean category : categories) {%>
                        <li class="nav-left-item"><a href="<c:url value="shop-detail-by-category"><c:param name="categoryId" value="<%=String.valueOf(category.getId())%>"/></c:url>" class="nav-left-link">Sản
                            phẩm <%=category.getName()%>
                        </a>
                            <ul class="pop-right">
                                <%
                                    int categoryId = category.getId();
                                    List<CategoryTypeBean> categoryTypes = categoryTypeMap.get(categoryId);
                                    for (CategoryTypeBean categoryType : categoryTypes) {
                                %>
                                <li class="pop-right-item"><a
                                        href="<c:url value="/shop-detail-by-type">
                                                <c:param name="categoryTypeId" value="<%=String.valueOf(categoryType.getId())%>"/>
                                                <c:param name="page" value="1"/>
                                                <c:param name="sort" value="none"/>
                                                <c:param name="range" value="none"/>
                                              </c:url>" class="pop-right-link"><%=categoryType.getName()%>
                                </a></li>
                                <% } %>
                            </ul>
                        </li>
                        <% } %>
                    </ul>
                </div>
            </div>

            <div class="col-9">
                <%
                    List<CategoryBean> categoriesForProduct = (List<CategoryBean>) request.getAttribute("categories");
                    Map<Integer, List<ProductBean>> productMap = (Map<Integer, List<ProductBean>>) request.getAttribute("productMap");
                    for (CategoryBean category : categoriesForProduct) {
                %>
                <div class="row">
                    <div class="col-12 col-md-6 col-lg-3 mb-5 dp-flex justify-content-center align-items-center darkredbg">
                        <div class="product-list-title dp-flex flex-column justify-content-center align-items-center">
                            <h5 class="product-list-madeby">
                                Sản phẩm làm từ
                            </h5>
                            <h4 class="product-category"><%=category.getName().toUpperCase()%>
                            </h4>
                            <h4 class="product-category">-></h4>
                        </div>
                    </div>
                    <%
                        int categoryId = category.getId();
                        List<ProductBean> products = productMap.get(categoryId);
                        for (ProductBean product : products) {
                    %>
                    <div class="col-12 col-md-6 col-lg-3 mb-5">
                        <div class="product-item">
                            <%
                                Map<Integer, ProductImageBean> productImage = (Map<Integer, ProductImageBean>) request.getAttribute("imageMap");
                                ProductImageBean imageBean = productImage.get(product.getId());
                            %>
                            <img  style="height: 200px; width: 220px ; border-radius: 10px";
                                  src="https://lh5.googleusercontent.com/proxy/eK0xfDQeqkiqb97ZgvmiagYAqVlQSiexe-vtB1qmEBYl_zjmdXqk2-4VipHyT9mBLnXdKGSdM45rngLuyJafBATmfhS83W-oRC5aRIdEAR5PvrLYsRVAnXl7aXlGem3CvOLhBb7dc8KZ9_tilAmBglzp953EkA"
                                  class="img-fluid product-thumbnail">
                            <h3 class="product-title"><%=product.getName()%>
                            </h3>
                            <strong class="product-price"><f:formatNumber value="<%=product.getDiscountPrice()%>"
                                                                          pattern="#,##0.##"/>₫</strong>
                            <div class="origin-price-and-discount">
                                <del><f:formatNumber value="<%=product.getOriginalPrice()%>" pattern="#,##0.##"/>₫</del>
                                <label><f:formatNumber value="<%=product.getDiscountPercent()%>" pattern="##0"/>%</label>
                            </div>
                            <a href="<c:url value="/cart-adding"><c:param name="productId" value="<%=String.valueOf(product.getId())%>"/><c:param name="requestBy" value="shop"/></c:url>" class="btn-pop-mini left">
                                <i class="fa-solid fa-cart-plus fa-xl" style="color: #2a1710"></i>
                                <p class="content-btn-mini">Thêm vào giỏ hàng</p>
                            </a>
                            <a href="<c:url value="/product-detail"><c:param name="id" value="<%=String.valueOf(product.getId())%>"/></c:url>" class="btn-pop-mini right">
                                <i class="fa-solid fa-info fa-xl" style="color: #2a1710"></i>
                                <p class="content-btn-mini">Chi tiết sản phẩm</p>
                            </a>
                        </div>
                    </div>
                    <% } %>
                </div>
                <div class="row">
                    <div class="d-flex justify-content-center mb-5"><a href="<c:url value="/shop-detail-by-category">
                                                                                <c:param name="categoryId" value="<%=String.valueOf(category.getId())%>"/>
                                                                            </c:url>" class="more">Xem thêm -></a>
                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>
<!-- End Shop Section -->
<jsp:include page="/common/client/footer.jsp"/>

<script>
    // Wait for the DOM to be ready
    $(document).ready(function() {
        // Set a timeout to close the alert after 3000 milliseconds (3 seconds)
        setTimeout(function() {
            $("#autoDismissAlert").alert('close');
        }, 3000);
    });
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="<c:url value="/templates/client/js/bootstrap.bundle.min.js"/>"></script>
<script src="<c:url value="/templates/client/js/tiny-slider.js"/>"></script>
<script src="<c:url value="/templates/client/js/custom.js"/>"></script>
</body>
</html>
