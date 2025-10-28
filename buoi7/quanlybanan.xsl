<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<html>
<head>
    <title>Kết quả truy vấn quản lý bàn ăn</title>
    <style>
        body { font-family: Arial; background-color: #f8f9fa; margin: 20px; }
        h2 { background-color: #007BFF; color: white; padding: 10px; border-radius: 5px; }
        table { border-collapse: collapse; width: 100%; margin-bottom: 30px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #e9ecef; }
        tr:nth-child(even) { background-color: #f2f2f2; }
    </style>
</head>
<body>
<h1 style="color:#007BFF;">KẾT QUẢ TRUY VẤN QUẢN LÝ BÀN ĂN</h1>

<!-- 1️⃣ Danh sách tất cả các bàn -->
<h2>1. Danh sách tất cả các bàn</h2>
<table>
<tr><th>STT</th><th>Số bàn</th><th>Tên bàn</th></tr>
<xsl:for-each select="QUANLY/BANS/BAN">
<tr>
<td><xsl:value-of select="position()"/></td>
<td><xsl:value-of select="SOBAN"/></td>
<td><xsl:value-of select="TENBAN"/></td>
</tr>
</xsl:for-each>
</table>

<!-- 2️⃣ Danh sách nhân viên -->
<h2>2. Danh sách nhân viên</h2>
<table>
<tr><th>STT</th><th>Mã NV</th><th>Tên NV</th><th>Giới tính</th><th>SĐT</th><th>Địa chỉ</th></tr>
<xsl:for-each select="QUANLY/NHANVIENS/NHANVIEN">
<tr>
<td><xsl:value-of select="position()"/></td>
<td><xsl:value-of select="MANV"/></td>
<td><xsl:value-of select="TENV"/></td>
<td><xsl:value-of select="GIOITINH"/></td>
<td><xsl:value-of select="SDT"/></td>
<td><xsl:value-of select="DIACHI"/></td>
</tr>
</xsl:for-each>
</table>

<!-- 3️⃣ Danh sách món ăn -->
<h2>3. Danh sách món ăn</h2>
<table>
<tr><th>STT</th><th>Mã món</th><th>Tên món</th><th>Giá</th></tr>
<xsl:for-each select="QUANLY/MONS/MON">
<tr>
<td><xsl:value-of select="position()"/></td>
<td><xsl:value-of select="MAMON"/></td>
<td><xsl:value-of select="TENMON"/></td>
<td><xsl:value-of select="GIA"/></td>
</tr>
</xsl:for-each>
</table>

<!-- 4️⃣ Thông tin nhân viên NV02 -->
<h2>4. Thông tin nhân viên NV02</h2>
<table>
<tr><th>STT</th><th>Mã NV</th><th>Tên NV</th><th>SĐT</th><th>Địa chỉ</th><th>Giới tính</th></tr>
<xsl:for-each select="QUANLY/NHANVIENS/NHANVIEN[MANV='NV02']">
<tr>
<td>1</td>
<td><xsl:value-of select="MANV"/></td>
<td><xsl:value-of select="TENV"/></td>
<td><xsl:value-of select="SDT"/></td>
<td><xsl:value-of select="DIACHI"/></td>
<td><xsl:value-of select="GIOITINH"/></td>
</tr>
</xsl:for-each>
</table>

<!-- 5️⃣ Món ăn có giá > 50,000 -->
<h2>5. Danh sách món ăn có giá &gt; 50,000</h2>
<table>
<tr><th>STT</th><th>Tên món</th><th>Giá</th></tr>
<xsl:for-each select="QUANLY/MONS/MON[GIA&gt;50000]">
<tr>
<td><xsl:value-of select="position()"/></td>
<td><xsl:value-of select="TENMON"/></td>
<td><xsl:value-of select="GIA"/></td>
</tr>
</xsl:for-each>
</table>

<!-- 6️⃣ Thông tin hóa đơn HD03 -->
<h2>6. Thông tin hóa đơn HD03</h2>
<table>
<tr><th>Tên nhân viên</th><th>Số bàn</th><th>Ngày lập</th><th>Tổng tiền</th></tr>
<xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD03']">
<tr>
<td><xsl:value-of select="/QUANLY/NHANVIENS/NHANVIEN[MANV=current()/MANV]/TENV"/></td>
<td><xsl:value-of select="SOBAN"/></td>
<td><xsl:value-of select="NGAYLAP"/></td>
<td><xsl:value-of select="TONGTIEN"/></td>
</tr>
</xsl:for-each>
</table>

<!-- 7️⃣ Tên các món trong hóa đơn HD02 -->
<h2>7. Tên các món ăn trong hóa đơn HD02</h2>
<table>
<tr><th>STT</th><th>Tên món</th></tr>
<xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD02']/CTHDS/CTHD">
<tr>
<td><xsl:value-of select="position()"/></td>
<td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/TENMON"/></td>
</tr>
</xsl:for-each>
</table>

<!-- 8️⃣ Tên nhân viên lập hóa đơn HD02 -->
<h2>8. Tên nhân viên lập hóa đơn HD02</h2>
<table>
<tr><th>Tên nhân viên</th></tr>
<xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD02']">
<tr>
<td><xsl:value-of select="/QUANLY/NHANVIENS/NHANVIEN[MANV=current()/MANV]/TENV"/></td>
</tr>
</xsl:for-each>
</table>

<!-- 9️⃣ Đếm số bàn -->
<h2>9. Số lượng bàn</h2>
<p><b>Tổng số bàn:</b> <xsl:value-of select="count(QUANLY/BANS/BAN)"/></p>

<!-- 🔟 Đếm số hóa đơn lập bởi NV01 -->
<h2>10. Số hóa đơn lập bởi NV01</h2>
<p><b>Số lượng:</b> <xsl:value-of select="count(QUANLY/HOADONS/HOADON[MANV='NV01'])"/></p>

<!-- 11️⃣ Danh sách món từng bán cho bàn số 2 -->
<h2>11. Danh sách món từng bán cho bàn số 2</h2>
<table>
<tr><th>STT</th><th>Tên món</th></tr>
<xsl:for-each select="QUANLY/HOADONS/HOADON[SOBAN=2]/CTHDS/CTHD">
<tr>
<td><xsl:value-of select="position()"/></td>
<td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/TENMON"/></td>
</tr>
</xsl:for-each>
</table>

<!-- 12️⃣ Nhân viên từng lập hóa đơn cho bàn số 3 -->
<h2>12. Danh sách nhân viên từng lập hóa đơn cho bàn số 3</h2>
<table>
<tr><th>STT</th><th>Tên nhân viên</th></tr>
<xsl:for-each select="QUANLY/HOADONS/HOADON[SOBAN=3]">
<tr>
<td><xsl:value-of select="position()"/></td>
<td><xsl:value-of select="/QUANLY/NHANVIENS/NHANVIEN[MANV=current()/MANV]/TENV"/></td>
</tr>
</xsl:for-each>
</table>

<!-- 13️⃣ Món ăn được gọi nhiều hơn 1 lần -->
<h2>13. Các món ăn được gọi nhiều hơn 1 lần</h2>
<table>
<tr><th>STT</th><th>Tên món</th><th>Tổng số lượng</th></tr>
<xsl:for-each select="QUANLY/MONS/MON">
    <xsl:variable name="mam" select="MAMON"/>
    <xsl:variable name="total" select="sum(/QUANLY/HOADONS/HOADON/CTHDS/CTHD[MAMON=$mam]/SOLUONG)"/>
    <xsl:if test="$total &gt; 1">
    <tr>
        <td><xsl:value-of select="position()"/></td>
        <td><xsl:value-of select="TENMON"/></td>
        <td><xsl:value-of select="$total"/></td>
    </tr>
    </xsl:if>
</xsl:for-each>
</table>

<!-- 14️⃣ Hóa đơn chi tiết HD04 -->
<h2>14. Hóa đơn chi tiết tính tiền cho HD04</h2>
<table>
<tr><th>STT</th><th>Mã món</th><th>Tên món</th><th>Đơn giá</th><th>Số lượng</th><th>Thành tiền</th></tr>
<xsl:for-each select="QUANLY/HOADONS/HOADON[SOHD='HD04']/CTHDS/CTHD">
<tr>
<td><xsl:value-of select="position()"/></td>
<td><xsl:value-of select="MAMON"/></td>
<td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/TENMON"/></td>
<td><xsl:value-of select="/QUANLY/MONS/MON[MAMON=current()/MAMON]/GIA"/></td>
<td><xsl:value-of select="SOLUONG"/></td>
<td><xsl:value-of select="SOLUONG * /QUANLY/MONS/MON[MAMON=current()/MAMON]/GIA"/></td>
</tr>
</xsl:for-each>
</table>

</body>
</html>
</xsl:template>
</xsl:stylesheet>
