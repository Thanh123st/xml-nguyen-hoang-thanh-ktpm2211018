from lxml import etree
from pathlib import Path

XML_FILE = Path("quanlybanan.xml")   # đổi đường dẫn nếu đặt nơi khác
if not XML_FILE.exists():
    raise FileNotFoundError(f"Không tìm thấy {XML_FILE.resolve()}")

root = etree.parse(str(XML_FILE)).getroot()

queries = [
    ("Lấy tất cả bàn", "/QUANLY/BANS/BAN"),
    ("Lấy tất cả nhân viên", "/QUANLY/NHANVIENS/NHANVIEN"),
    ("Lấy tất cả tên món", "/QUANLY/MONS/MON/TENMON"),
    ("Lấy tên nhân viên có mã NV02", "/QUANLY/NHANVIENS/NHANVIEN[MANV='NV02']/TENV"),
    ("Lấy tên & SĐT của NV03", "/QUANLY/NHANVIENS/NHANVIEN[MANV='NV03']/TENV | /QUANLY/NHANVIENS/NHANVIEN[MANV='NV03']/SDT"),
    ("Lấy tên món có giá > 50,000", "/QUANLY/MONS/MON[GIA>50000]/TENMON"),
    ("Lấy số bàn của hóa đơn HD03", "/QUANLY/HOADONS/HOADON[SOHD='HD03']/SOBAN"),
    ("Lấy tên món có mã M02", "/QUANLY/MONS/MON[MAMON='M02']/TENMON"),
    ("Lấy ngày lập của hóa đơn HD03", "/QUANLY/HOADONS/HOADON[SOHD='HD03']/NGAYLAP"),
    ("Lấy tất cả mã món trong hóa đơn HD01", "/QUANLY/HOADONS/HOADON[SOHD='HD01']/CTHDS/CTHD/MAMON"),
    ("Lấy tên món trong hóa đơn HD01", "/QUANLY/MONS/MON[MAMON = /QUANLY/HOADONS/HOADON[SOHD='HD01']/CTHDS/CTHD/MAMON]/TENMON"),
    ("Lấy tên nhân viên lập hóa đơn HD02", "/QUANLY/NHANVIENS/NHANVIEN[MANV = /QUANLY/HOADONS/HOADON[SOHD='HD02']/MANV]/TENV"),
    ("Đếm số bàn", "count(/QUANLY/BANS/BAN)"),
    ("Đếm số hóa đơn lập bởi NV01", "count(/QUANLY/HOADONS/HOADON[MANV='NV01'])"),
    ("Tên tất cả món trong hóa đơn của bàn số 2", "/QUANLY/MONS/MON[MAMON = /QUANLY/HOADONS/HOADON[SOBAN=2]/CTHDS/CTHD/MAMON]/TENMON"),
    ("Tất cả nhân viên từng lập hóa đơn cho bàn số 3 (tên)", "/QUANLY/NHANVIENS/NHANVIEN[MANV = /QUANLY/HOADONS/HOADON[SOBAN=3]/MANV]/TENV"),
    ("Tất cả hóa đơn mà nhân viên nữ lập (SOHD)", "/QUANLY/HOADONS/HOADON[MANV = /QUANLY/NHANVIENS/NHANVIEN[GIOITINH='Nữ']/MANV]/SOHD"),
    ("Tất cả nhân viên từng phục vụ bàn số 1 (tên)", "/QUANLY/NHANVIENS/NHANVIEN[MANV = /QUANLY/HOADONS/HOADON[SOBAN=1]/MANV]/TENV"),
    ("Tên món được gọi nhiều hơn 1 lần","/QUANLY/MONS/MON[MAMON = (/QUANLY//MAMON[. = following::MAMON and not(. = preceding::MAMON)])]/TENMON"),
]

def show(title, xp):
    res = root.xpath(xp)
    print(f"\n► {title}\nXPath: {xp}")
    if isinstance(res, list):
        if not res:
            print("Kết quả: []")
        else:
            for r in res:
                if isinstance(r, etree._Element):
                    print(f"  - <{r.tag}>: {(r.text or '').strip()}")
                else:
                    print(f"  - {r}")
    else:
        print(f"  - {res}")

print("=== KIỂM TRA XPATH TRÊN quanlybanan.xml ===")
for title, xp in queries:
    show(title, xp)
