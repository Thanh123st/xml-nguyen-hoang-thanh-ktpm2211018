# sv.py
from lxml import etree
from pathlib import Path

# --- Đọc file XML ---
xml_path = Path("sv.xml")  # đổi nếu đặt nơi khác
if not xml_path.exists():
    raise FileNotFoundError(f"Không tìm thấy {xml_path.resolve()}")

# Dùng parse để giữ cấu trúc, whitespace hợp lý
root = etree.parse(str(xml_path)).getroot()

# --- Danh sách truy vấn XPath ---
queries = [
    ("Lấy tất cả sinh viên", "/school/student"),
    ("Liệt kê tên tất cả sinh viên", "/school/student/name"),
    ("Lấy tất cả id của sinh viên", "/school/student/id"),
    ("Lấy ngày sinh của SV01", "/school/student[id='SV01']/date"),
    ("Lấy các khóa học", "/school/enrollment/course"),
    ("Lấy toàn bộ thông tin sinh viên đầu tiên", "/school/student[1]"),
    ("Mã sinh viên học Vatly203", "/school/enrollment[course='Vatly203']/studentRef"),
    ("Tên sinh viên học Toan101", "/school/student[id = /school/enrollment[course='Toan101']/studentRef]/name"),
    ("Tên sinh viên học Vatly203", "/school/student[id = /school/enrollment[course='Vatly203']/studentRef]/name"),
    ("Ngày sinh của SV01 (lặp)", "/school/student[id='SV01']/date"),
    ("Tên & ngày sinh sinh năm 1997", "/school/student[starts-with(date,'1997')]/name | /school/student[starts-with(date,'1997')]/date"),

    # FIX: so sánh ngày trước 1998 bằng cách bỏ dấu '-' và so sánh số
    ("Tên sinh viên sinh trước 1998",
     "/school/student[number(translate(date,'-','')) < 19980101]/name"),

    ("Đếm tổng số sinh viên", "count(/school/student)"),
    ("<date> anh em ngay sau <name> của SV01", "/school/student[id='SV01']/name/following-sibling::date[1]"),
    ("<id> anh em ngay trước <name> của SV02", "/school/student[id='SV02']/name/preceding-sibling::id[1]"),
    ("<course> trong cùng <enrollment> với SV03", "/school/enrollment[studentRef='SV03']/course"),
    ("Sinh viên họ 'Trần'", "/school/student[starts-with(normalize-space(name), 'Trần')]"),
    ("Năm sinh của SV01", "substring(/school/student[id='SV01']/date, 1, 4)"),
]

# --- Chạy truy vấn và in kết quả ---
print("=== KẾT QUẢ TRÊN FILE GỐC ===")
for title, xp in queries:
    res = root.xpath(xp)
    print(f"\n► {title}\nXPath: {xp}")

    # Kết quả là list (node-set hoặc list giá trị)
    if isinstance(res, list):
        if not res:
            print("Kết quả: []")
        else:
            for item in res:
                if isinstance(item, etree._Element):
                    print(f"  - <{item.tag}>: {(item.text or '').strip()}")
                else:
                    print(f"  - {item}")
    else:
        # Kết quả là số/chuỗi (ví dụ count(), substring())
        print(f"Kết quả: {res}")

# --- Thêm 2 sinh viên chưa đăng ký ---
sv04 = etree.Element("student")
etree.SubElement(sv04, "id").text = "SV04"
etree.SubElement(sv04, "name").text = "Trần Minh Khoa"
etree.SubElement(sv04, "date").text = "1999-05-20"

sv05 = etree.Element("student")
etree.SubElement(sv05, "id").text = "SV05"
etree.SubElement(sv05, "name").text = "Nguyễn An"
etree.SubElement(sv05, "date").text = "1998-03-02"

root.append(sv04)
root.append(sv05)

# --- Truy vấn sinh viên chưa đăng ký ---
xp_no_enroll = "/school/student[not(id = /school/enrollment/studentRef)]"
print("\n=== SAU KHI THÊM 2 SINH VIÊN (SV04, SV05) CHƯA ĐĂNG KÝ ===")
print(f"► Sinh viên chưa đăng ký môn nào\nXPath: {xp_no_enroll}")
res = root.xpath(xp_no_enroll)
if not res:
    print("Kết quả: []")
else:
    for st in res:
        sid = st.findtext("id")
        sname = st.findtext("name")
        print(f"  - {sid}: {sname}")

