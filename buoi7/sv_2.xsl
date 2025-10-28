<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>

<xsl:template match="/">
<html>
<head>
    <title>Kết quả truy vấn sinh viên</title>
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
    <h1 style="color:#007BFF;">KẾT QUẢ TRUY VẤN SINH VIÊN</h1>

    <!-- 1️⃣ Liệt kê thông tin tất cả sinh viên -->
    <h2>1. Liệt kê thông tin tất cả sinh viên (Mã và Họ tên)</h2>
    <table>
        <tr><th>Mã sinh viên</th><th>Họ tên</th></tr>
        <xsl:apply-templates select="school/student" mode="all"/>
    </table>

    <!-- 2️⃣ Liệt kê danh sách sinh viên sắp xếp theo điểm -->
    <h2>2. Danh sách sinh viên gồm mã, tên, điểm (sắp xếp điểm giảm dần)</h2>
    <table>
        <tr><th>Mã</th><th>Họ tên</th><th>Điểm</th></tr>
        <xsl:for-each select="school/student">
            <xsl:sort select="grade" data-type="number" order="descending"/>
            <tr>
                <td><xsl:value-of select="id"/></td>
                <td><xsl:value-of select="name"/></td>
                <td><xsl:value-of select="grade"/></td>
            </tr>
        </xsl:for-each>
    </table>

    <!-- 3️⃣ Danh sách sinh viên sinh tháng gần nhau -->
    <h2>3. Danh sách sinh viên sinh tháng gần nhau</h2>
    <table>
        <tr><th>STT</th><th>Họ tên</th><th>Ngày sinh</th></tr>
        <xsl:for-each select="school/student">
            <xsl:sort select="substring(date,6,2)" data-type="number"/>
            <tr>
                <td><xsl:value-of select="position()"/></td>
                <td><xsl:value-of select="name"/></td>
                <td><xsl:value-of select="date"/></td>
            </tr>
        </xsl:for-each>
    </table>

    <!-- 4️⃣ Danh sách các khóa học có sinh viên học -->
    <h2>4. Danh sách các khóa học có sinh viên học (sắp xếp theo tên khóa học)</h2>
    <table>
        <tr><th>Mã khóa học</th><th>Tên khóa học</th></tr>
        <xsl:for-each select="school/course">
            <xsl:sort select="name"/>
            <xsl:variable name="cid" select="id"/>
            <xsl:if test="/school/enrollment/courseRef = $cid">
                <tr>
                    <td><xsl:value-of select="id"/></td>
                    <td><xsl:value-of select="name"/></td>
                </tr>
            </xsl:if>
        </xsl:for-each>
    </table>

    <!-- 5️⃣ Danh sách sinh viên học khóa Hóa học 201 -->
    <h2>5. Danh sách sinh viên đăng ký khóa học "Hóa học 201"</h2>
    <table>
        <tr><th>Mã sinh viên</th><th>Họ tên</th></tr>
        <xsl:variable name="courseID" select="/school/course[name='Hóa học 201']/id"/>
        <xsl:for-each select="/school/enrollment[courseRef=$courseID]">
            <xsl:variable name="sid" select="studentRef"/>
            <tr>
                <td><xsl:value-of select="$sid"/></td>
                <td><xsl:value-of select="/school/student[id=$sid]/name"/></td>
            </tr>
        </xsl:for-each>
    </table>

    <!-- 6️⃣ Danh sách sinh viên sinh năm 1997 -->
    <h2>6. Danh sách sinh viên sinh năm 1997</h2>
    <table>
        <tr><th>Mã</th><th>Họ tên</th><th>Ngày sinh</th></tr>
        <xsl:for-each select="school/student[starts-with(date,'1997')]">
            <tr>
                <td><xsl:value-of select="id"/></td>
                <td><xsl:value-of select="name"/></td>
                <td><xsl:value-of select="date"/></td>
            </tr>
        </xsl:for-each>
    </table>

    <!-- 7️⃣ Thống kê sinh viên họ “Trần” -->
    <h2>7. Danh sách sinh viên họ "Trần"</h2>
    <table>
        <tr><th>Mã</th><th>Họ tên</th><th>Ngày sinh</th></tr>
        <xsl:for-each select="school/student[starts-with(name,'Trần')]">
            <tr>
                <td><xsl:value-of select="id"/></td>
                <td><xsl:value-of select="name"/></td>
                <td><xsl:value-of select="date"/></td>
            </tr>
        </xsl:for-each>
    </table>
</body>
</html>
</xsl:template>

<!-- Template mặc định cho sinh viên -->
<xsl:template match="student" mode="all">
    <tr>
        <td><xsl:value-of select="id"/></td>
        <td><xsl:value-of select="name"/></td>
    </tr>
</xsl:template>

</xsl:stylesheet>
