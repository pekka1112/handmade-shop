<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.ltw.bean.CategoryBean" %>
<%@ page import="java.util.List" %>
<%@ page import="com.ltw.bean.CategoryTypeBean" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.ltw.bean.ProductBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
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
    <link rel="stylesheet" href="">

    <!-- Pagination -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.min.js"></script>

    <title>DDD. - Nghệ thuật mỹ nghệ</title>
</head>

<%-- Thankfat : CSS cho thanh Search--%>
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

<!-- Start Wood Section -->
<div class="product-section product-section before-footer-section position-relative-top-50px">
    <div class="container">
        <%
            String sort = (String) request.getAttribute("sort");
            String range = (String) request.getAttribute("range");
            String key = (String) request.getAttribute("key");
        %>
        <div class="row mb-3">
            <form action="<c:url value="/search"/>" method="get">
                <input type="hidden" name="sort" value="<%=sort%>">
                <input type="hidden" name="range" value="<%=range%>">
                <input type="hidden" name="page" value="1">
                <div class="input-group" >
                    <%-- Ô tìm kiếm --%>
                    <input type="text" class="form-control rounded" id="search_bar" placeholder="Nhập từ khóa để tìm kiếm sản phẩm"
                           style=" border-top-left-radius: 20px !important;border-bottom-left-radius: 20px !important; font-size: 30px"
                           aria-label="Search" aria-describedby="search-addon" name="key"/>
                    <%-- Nút tìm kiếm --%>
                    <button type="submit" class="btn btn-outline-primary" id="search_btn"  style="width: 150px;; background-color: #2a1710 " data-mdb-ripple-init>
                        <i style="font-size: 25px ; color: #e3bd74" class="fa-solid fa-magnifying-glass" ></i>
                    </button>
                </div>
            </form>
        </div>
        <div class="row">
            <div class="col-3 pe-3 nav-left">
                <div class="nav-left-block">
                    <div class="mb-5">
                        <p class="nav-left-title">Danh mục sản phẩm</p>
                        <%
                            List<CategoryBean> categories = (List<CategoryBean>) request.getAttribute("categories");
                            Map<Integer, List<CategoryTypeBean>> categoryTypeMap = (Map<Integer, List<CategoryTypeBean>>) request.getAttribute("categoryTypeMap");
                        %>
                        <ul class="nav-left-list">
                            <% for (CategoryBean category : categories) {%>
                            <li class="nav-left-item"><a
                                    href="<c:url value="shop-detail-by-category"><c:param name="categoryId" value="<%=String.valueOf(category.getId())%>"/></c:url>"
                                    class="nav-left-link">Sản
                                phẩm <%=category.getName()%>
                            </a>
                                <ul class="pop-right">
                                    <%
                                        int categoryId = category.getId();
                                        List<CategoryTypeBean> categoryTypes = categoryTypeMap.get(categoryId);
                                        for (CategoryTypeBean categoryType : categoryTypes) {
                                    %>
                                    <li class="pop-right-item"><a href="<c:url value="/shop-detail-by-type">
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

                    <div class="sorting px-1">
                        <form action="<c:url value="/search"/>" method="get">
                            <input type="hidden" name="page" value="1">
                            <input type="hidden" name="key" value="<%=key%>">
                            <div><h5>Sắp xếp theo giá</h5></div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="sort" id="option1" value="none" <%if (sort.equals("none")) {%>checked<%}%>>
                                <label class="form-check-label" for="option1">Không</label>
                            </div>

                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="sort" id="option2" value="asc" <%if (sort.equals("asc")) {%>checked<%}%>>
                                <label class="form-check-label" for="option2">Tăng</label>
                            </div>

                            <div class="form-check form-check-inline">
                                <input class="form-check-input" type="radio" name="sort" id="option3" value="desc" <%if (sort.equals("desc")) {%>checked<%}%>>
                                <label class="form-check-label" for="option3">Giảm</label>
                            </div>

                            <div class="mt-2"><h5>Khoảng giá</h5></div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="range" id="option4" value="none" <%if (range.equals("none")) {%>checked<%}%>>
                                <label class="form-check-label" for="option4">Không</label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="range" id="option5" value="0-to-499" <%if (range.equals("0-to-499")) {%>checked<%}%>>
                                <label class="form-check-label" for="option5">0 - 499.000đ</label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="range" id="option6" value="500-to-2999" <%if (range.equals("500-to-2999")) {%>checked<%}%>>
                                <label class="form-check-label" for="option6">500.000đ - 2.999.000đ</label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="range" id="option7" value="3000-to-9999" <%if (range.equals("3000-to-9999")) {%>checked<%}%>>
                                <label class="form-check-label" for="option7">3.000.000đ - 9.999.000đ</label>
                            </div>

                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="range" id="option8" value="up-to-10000" <%if (range.equals("up-to-10000")) {%>checked<%}%>>
                                <label class="form-check-label" for="option8">10.000.000đ trở lên</label>
                            </div>

                            <button class="btn btn-primary" type="submit">Gửi</button>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-9">
                <div class="row">
                    <div class="col-12" id="luc-binh-go">
                        <h1 class="product-type-title">Kết quả cho "<%=key%>"
                        </h1>
                        <hr size="4">
                    </div>
                </div>

                <div class="row">
                    <%
                        List<ProductBean> products = (List<ProductBean>) request.getAttribute("products");
                        for (ProductBean product : products) {
                    %>
                    <!-- Start Column 1 -->
                    <div class="col-12 col-md-6 col-lg-3 mb-5">
                        <div class="product-item">
                            <img  style="height: 200px; width: 220px ; border-radius: 10px";
                                    src="https://lh5.googleusercontent.com/proxy/eK0xfDQeqkiqb97ZgvmiagYAqVlQSiexe-vtB1qmEBYl_zjmdXqk2-4VipHyT9mBLnXdKGSdM45rngLuyJafBATmfhS83W-oRC5aRIdEAR5PvrLYsRVAnXl7aXlGem3CvOLhBb7dc8KZ9_tilAmBglzp953EkA" class="img-fluid product-thumbnail">
                            <h3 class="product-title"><%=product.getName()%></h3>
                            <strong class="product-price"><f:formatNumber value="<%=product.getDiscountPrice()%>"
                                                                          pattern="#,##0.##"/>₫</strong>
                            <div class="origin-price-and-discount">
                                <del><f:formatNumber value="<%=product.getOriginalPrice()%>" pattern="#,##0.##"/>₫</del>
                                <label><f:formatNumber value="<%=product.getDiscountPercent()%>"
                                                       pattern="##0"/>%</label>
                            </div>
                            <a href="<c:url value="/cart-adding"><c:param name="productId" value="<%=String.valueOf(product.getId())%>"/><c:param name="requestBy" value="shop-detail-by-type"/></c:url>"
                               class="btn-pop-mini left">
                                <i class="fa-solid fa-cart-plus fa-xl" style="color: #2a1710"></i>
                                <p class="content-btn-mini">Thêm vào giỏ hàng</p>
                            </a>
                            <a href="<c:url value="/product-detail"><c:param name="productId" value="<%=String.valueOf(product.getId())%>"/></c:url>" class="btn-pop-mini right">
                                <i class="fa-solid fa-info fa-xl" style="color: #2a1710"></i>
                                <p class="content-btn-mini">Chi tiết sản phẩm</p>
                            </a>
                        </div>
                    </div>
                    <!-- End Column 1 -->
                    <% } %>
                </div>
                <div class="row justify-content-center">
                    <form action="<c:url value="/search"/>" id="paginationForm" method="get">
                        <ul class="pagination justify-content-center" id="pagination"></ul>
                        <!-- Có input nhưng hidden (ẩn) đi -->
                        <input type="hidden" name="key" value="<%=key%>">
                        <input type="hidden" value="" id="page" name="page"/>
                        <input type="hidden" name="sort" value="<%=sort%>">
                        <input type="hidden" name="range" value="<%=range%>">
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%
    int serverPage = (int) request.getAttribute("serverPage");
    int serverTotalPages = (int) request.getAttribute("serverTotalPages");
%>

<!-- End Wood Section -->
<jsp:include page="/common/client/footer.jsp"/>

<script>
    let currentPage = <%=serverPage%>;
    let totalPages =  <%=serverTotalPages%>;
    let limit = 2;
    $(function () {
        window.pagObj = $('#pagination').twbsPagination({
            // Kiểm tra các thuộc tính trong file .js (trong default)
            totalPages: totalPages,
            // Đây là SỐ PAGE HIỂN THỊ TRONG THANH CHỌN PAGE
            visiblePages: 5,
            startPage: currentPage,
            onPageClick: function (event, page) {
                // Nếu page hiện tại khác page đang chọn thì mới cần submit
                if (currentPage !== page) {
                    // Đây là SỐ LƯỢNG ITEM TRONG 1 PAGE
                    $('#itemPerVisible').val(limit);
                    $('#page').val(page);
                    $('#paginationForm').submit();
                }
            }
        }).on('page', function (event, page) {
            console.info(page + ' (from event listening)');
        });
    });
</script>

<script src="<c:url value="/templates/client/js/bootstrap.bundle.min.js"/>"></script>
<script src="<c:url value="/templates/client/js/tiny-slider.js"/>"></script>
<script src="<c:url value="/templates/client/js/custom.js"/>"></script>
<script>
    document.getElementById('search_bar').addEventListener('focus', function() {
        this.style.fontSize = '25px';
    });

    document.getElementById('search_bar').addEventListener('blur', function() {
        this.style.fontSize = '25px';
    });
</script>
</body>
</html>
