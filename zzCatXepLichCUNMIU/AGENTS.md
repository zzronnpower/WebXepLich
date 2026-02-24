# agents.md
## Quy ước module (agents) trong Web App Xếp Lịch Làm Việc

> Lưu ý quan trọng:
> - Tài liệu này dùng từ “Agent” để mô tả **các module/service** trong một web app (không phải hệ multi-agent AI).
> - Trong code: **tiếng Việt không dấu** cho tên file/folder/ham/bien/cot DB/JSON key/endpoint.
> - Trong comment, mô tả, README, UI hiển thị: có thể dùng **tiếng Việt có dấu**.

---

## 0) Quy ước đặt tên (không dấu trong code)

### Tên folder/file/module (không dấu)
- scheduler/ (xu ly xep lich)
- validation/ (kiem tra du lieu)
- mapping/ (anh xa hien thi)
- export/ (xuat excel)
- web/ (routes + templates + static)

### Tên biến/cột DB/JSON key (không dấu, snake_case)
Ví dụ:
- ma_nv, ten_nv, vai_tro, cap_do, muc_uu_tien, gio_toi_da_tuan
- ngay, chi_nhanh, ca, so_nguoi_can, do_quan_trong, senior_toi_thieu
- trang_thai (OFF), ghi_chu

> UI có thể hiển thị “Mã NV”, “Tên NV”… có dấu; nhưng dữ liệu/keys trong code không dấu.

---

## 1) SchedulerAgent (SchedulingService) — Module Xếp Lịch

### Vai trò
Chịu trách nhiệm chạy thuật toán xếp lịch tự động theo tuần, thỏa **hard constraints** và tối ưu **soft constraints**.

### Input (từ DB)
- nhan_vien:
  - ma_nv, ten_nv
  - vai_tro/ky_nang (có thể nhiều)
  - cap_do (junior/senior) (tùy chọn)
  - muc_uu_tien (số)
  - gio_toi_da_tuan (số)
  - ca_ua_thich (danh sách)
  - ca_tranh (danh sách)
- ngay_nghi:
  - ma_nv, ngay, trang_thai=OFF, ghi_chu
- nhu_cau_ca (theo ngày, theo chi nhánh):
  - ngay, chi_nhanh (TTV/197/796)
  - ca (8-19, 8_30-19_30, 9-20, 10-21...)
  - so_nguoi_can
  - vai_tro_yeu_cau (tùy chọn)
  - do_quan_trong (1-5) (tùy chọn)
  - senior_toi_thieu (tùy chọn)
- cau_hinh:
  - bat_buoc_di_chich_ngoai (true/false)
  - di_chich_ngoai_ca = "9-20" (mặc định)
- trong_so_uu_tien (weights)

### Hard constraints (BẮT BUỘC)
1) Không xếp vào ngày OFF.  
2) Đủ người cho từng nhu cầu ca (so_nguoi_can).  
3) Đúng vai_tro_yeu_cau nếu có.  
4) Không trùng ca cùng thời điểm; mặc định tối đa 1 ca/ngày/người (có setting để mở).  
5) Không vượt gio_toi_da_tuan.  
6) Nếu bật di_chich_ngoai: mỗi ngày đúng 1 người ca 9-20 (hoặc cấu hình).

### Soft constraints (TỐI ƯU THEO TRỌNG SỐ)
- Cộng điểm nếu trúng ca_ua_thich.  
- Trừ điểm nếu rơi vào ca_tranh.  
- Chia đều ca khó (di_chich_ngoai, ca muộn).  
- Chia đều cuối tuần.  
- Ca quan trọng ưu tiên senior hoặc muc_uu_tien cao.

### Trọng số ưu tiên theo nhân viên
- Mỗi nhân viên có thể gán tối đa 3 trọng số từ bảng `trong_so_uu_tien`.
- Giá trị dùng cho nhân viên được lấy tự động từ `trong_so_uu_tien.gia_tri`.
- Solver nhân hệ số này vào trọng số toàn cục khi tính điểm (ví dụ: 5 * 3).

### Output (lưu DB)
- lich_tuan (schedule_run):
  - id, tu_ngay, den_ngay, trang_thai (success/failed), created_at
- lich_chi_tiet (schedule_assignments):
  - schedule_run_id
  - ngay, chi_nhanh, ca
  - ma_nv
  - nhom_hien_thi (CN1/CN2/CN3/CN/Spa) (có thể để MappingAgent tính)

### Công nghệ đề xuất
- Python + OR-Tools (CP-SAT)

---

## 2) ValidationAgent (ValidationService) — Module Kiểm Tra Dữ Liệu

### Vai trò
Kiểm tra dữ liệu đầu vào và kết quả đầu ra để:
- báo lỗi rõ ràng trên web
- tránh “xếp lịch xong mới biết sai”

### Kiểm tra đầu vào (trước khi xếp)
- Thiếu dữ liệu bắt buộc (nhân viên thiếu gio_toi_da_tuan, thiếu vai_tro…)
- Nhu cầu ca không hợp lệ với chi nhánh (ví dụ 796 chỉ có ca 9-20)
- Thiếu nhân sự để đáp ứng tổng nhu cầu (ước lượng nhanh)
- Xung đột OFF

### Kiểm tra sau khi xếp
- Ca nào không đủ người
- Nhân viên nào bị vượt giờ/tuần
- Vi phạm “tối đa 1 ca/ngày” nếu bật

### Output
- errors[] (blocking) + warnings[] (không chặn)

---

## 3) MappingAgent (ViewModelMapper) — Module Ánh Xạ Hiển Thị Theo Template

### Vai trò
Chuyển dữ liệu lịch (assignments) sang đúng format hiển thị giống “lịch xếp tay”.

### Nhiệm vụ
- Quản lý mapping: (chi_nhanh + ca) -> nhom_hien_thi (CN1/CN2/CN3/CN/Spa)
  - mapping này phải cấu hình được trên trang quản trị (bảng mapping)
- Chuẩn hóa cho UI:
  - Cột: thứ + ngày
  - Hàng: CN1, CN2, CN3, CN, Spa
  - Mỗi ô: danh sách ten_nv (mỗi tên 1 dòng)

### Output
- view_model cho trang “Xem lịch”
- data structure cho ExportAgent

---

## 4) ExportAgent (ExportService) — Module Xuất Excel

### Vai trò
Xuất file Excel đúng layout template.

### Yêu cầu
- File: OUTPUT_Lich_Lam_Viec.xlsx
- Bố cục giống lịch xếp tay:
  - Header theo thứ/ngày
  - Các block theo group (CN1/CN2/CN3/CN/Spa)
  - Mỗi ô chứa danh sách tên xuống dòng
- Màu: dùng màu nền phân vùng theo group (đơn giản cũng được nhưng phải rõ)

### Output
- file .xlsx (trả về download trên web)

---

## 5) UIAgent (WebAdminModule) — Module Giao Diện Quản Trị

### Vai trò
Giao diện web để nhập liệu, chạy xếp lịch, xem lịch, tải Excel.

### Trang/Mục bắt buộc
- /nhan-vien: CRUD nhân viên
- /ngay-nghi: CRUD ngày nghỉ
- /nhu-cau-ca: CRUD nhu cầu ca theo ngày/chi nhánh
- /trong-so: chỉnh trọng số ưu tiên (weights)
- /mapping-nhom: mapping chi_nhanh+ca -> CN1/CN2/CN3/CN/Spa
- /xep-lich: chọn khoảng ngày + nút “Xếp lịch”
- /xem-lich/{schedule_run_id}: xem lịch dạng bảng
- /tai-excel/{schedule_run_id}: tải Excel

### Quy ước form & autofill
- Ưu tiên layout gọn bằng lưới dùng class: `.form-luoi`, `.truong`, `.truong--rong`, `.hanh-dong`.
- Với form dữ liệu nhiều, dùng dropdown chọn item và `data-*` attributes để tự điền (autofill)
  vào input/select/textarea. Mẫu đã áp dụng ở trang `/quan-ly` và `/nhan-vien`.
- Trọng số ưu tiên theo nhân viên được nhập bằng 3 dropdown (trọng số 1-3).
  Giá trị trọng số được lấy từ bảng `trong_so_uu_tien`.

Ví dụ cấu trúc autofill:

```html
<select name="nhan_vien_id">
  <option
    value="1"
    data-ten-nv="Hữu"
    data-cap-do="Bác sỹ chính"
    data-ca-ua-thich="1,3"
  >
    BS01 - Hữu
  </option>
</select>
```

```js
const option = select.options[select.selectedIndex]
inputTen.value = option.dataset.tenNv || ""
selectCapDo.value = option.dataset.capDo || ""
setMultiSelect(selectUaThich, (option.dataset.caUaThich || "").split(","))
```

> Gợi ý: UI dùng Jinja2 + Bootstrap để triển khai nhanh.

---

## 6) API Layer (Routes/Controllers) — Lớp Điều Phối

### Vai trò
Nhận request từ web, gọi đúng service/module, trả response.

Ví dụ flow nút “Xếp lịch”:
1) POST /api/xep-lich (tu_ngay, den_ngay)
2) ValidationService.validate_input(...)
3) SchedulingService.solve(...)
4) ValidationService.validate_output(...)
5) Lưu schedule_run + assignments
6) Trả schedule_run_id để UI chuyển sang trang xem lịch

---

## 7) Luồng hoạt động tổng quát

1) Người dùng nhập dữ liệu (nhân viên/ngày nghỉ/nhu cầu ca/mapping/weights).  
2) ValidationService kiểm tra input.  
3) SchedulingService chạy OR-Tools và tạo lịch.  
4) ValidationService kiểm tra kết quả.  
5) ViewModelMapper ánh xạ lịch để hiển thị giống template.  
6) UI hiển thị lịch và cho tải Excel bằng ExportService.

---

## 8) Ghi chú triển khai

- “Agent” ở đây = module/service trong cùng một codebase (monolith web app).
- Không bắt buộc tách microservice.
- Tất cả tên trong code không dấu để tránh lỗi encoding; UI/Docs/Comments có thể có dấu.

---

## 9) Quy tắc nhật ký bắt buộc sau mỗi lần code

- Sau khi hoàn thành bất kỳ thay đổi code nào, bắt buộc cập nhật đồng thời:
  - `backend/app/templates/chatlog.html`
  - `AGENTS.md`
  - `PROJECT_LOG.md`
- Thực hiện tự động, không chờ nhắc lại.
- Nếu có nhiều yêu cầu trong một phiên, gộp theo cụm thay đổi để log ngắn gọn, đủ truy vết.
- Khi có thay đổi UI tương tác (toggle, drag/drop, layout), ghi rõ hành vi ON/OFF và ràng buộc backend tương ứng trong `PROJECT_LOG.md`.
- Với lỗi hiển thị bảng (overlap, lệch hàng, wrap nút), luôn ghi rõ root-cause CSS và quy tắc khống chế layout (nowrap/min-width/flex-shrink) trong log cập nhật.
- Khi cần ổn định bố cục bảng hành động, ưu tiên `colgroup + table-layout: fixed` thay vì chỉ tăng width ở `td:last-child`.
- Với lỗi lệch hàng giữa cột "Nhóm / Ca" và cột phân công, ưu tiên dùng một lane offset chung (CSS variable) và áp đối xứng cho cả hai phía, tránh vá lệch bằng margin rời rạc.
- Với nghiệp vụ khóa OFF, chỉ khóa các bản ghi OFF có nguồn đăng ký chủ động từ trang ngày nghỉ (nguon=`user`); không khóa OFF sinh ra từ thuật toán hoặc thao tác kéo thả thủ công.
- Khi bấm Xếp lịch: OFF chỉ chứa nhân viên có đăng ký nghỉ; mọi nhân sự chưa được thuật toán phân công phải vào `CHUA_XEP` để người dùng duyệt/xếp tay.
- Nút `Tự xếp lịch` là chế độ manual-first: không chạy solver phân ca, chỉ prefill OFF theo đăng ký nghỉ và đưa toàn bộ còn lại vào `CHUA_XEP` để người dùng tự xếp.
- Khi có hai nút hành động chính song song trên cùng form (ví dụ `XẾP LỊCH` và `Tự xếp lịch`), giữ cùng kích thước để cân bằng bố cục; dùng màu nền khác biệt để phân vai thao tác.
- Trang `Lịch đã xếp` phải hỗ trợ quản trị vòng đời lịch: đổi tên (`ten_lich`) và xóa lịch cũ trực tiếp theo từng dòng, có xác nhận trước khi xóa.
- Khu ghi chú điều phối tạm (như `SPA OFF`) phải tách biệt khỏi bảng chính, dùng textarea nhiều dòng và mặc định không lưu (không DB, không cache) trừ khi user yêu cầu rõ cơ chế persistence.
- Khi user yêu cầu persistence cho `SPA OFF`, phải lưu theo từng `lich_tuan` và theo từng ngày trong tuần; khi mở lại lịch đã xếp phải prefill đúng ghi chú tương ứng từng ngày.
- Với lịch `TU_XEP`, sau mỗi lần lưu kéo-thả phải chuẩn hóa `ca_id`/`chi_nhanh_id` theo `thu_tu` dòng và mapping nhóm; nếu không, kiểm tra ràng buộc sẽ báo thiếu ảo dù UI đã sắp đúng.
- Khi lưu lịch, cần chuẩn hóa lại toàn bộ các dòng thuộc nhóm chi nhánh (không chỉ các card vừa kéo) để tránh tồn tại bản ghi cũ `ca_id`/`chi_nhanh_id` null gây báo thiếu ảo cho `796ADV` hoặc `Chích ngoài`.
- Cụm nút thao tác lịch nên đặt thành toolbar tách riêng phía trên tiêu đề bảng để tránh dồn chỗ trong header và giữ vùng bảng dễ đọc.
- Trang ChatLog ưu tiên hiển thị theo kiểu conversation (bubble User/Assistant, căn trái-phải rõ ràng), tránh layout card-grid gây khó theo dõi mạch hội thoại.
- Với toolbar thao tác lịch, có thể dùng màu nhấn riêng (ví dụ nền hồng nhạt + chữ đậm) khi user yêu cầu tăng độ nổi bật; giữ nguyên id/nút để không ảnh hưởng JS.
- Với tinh chỉnh màu toolbar thao tác lịch, ưu tiên tone sáng trung tính (ví dụ vàng nhạt) nếu màu nhấn hiện tại gây lệch tổng thể giao diện.
- Với tinh chỉnh typography bảng lịch, hỗ trợ chỉnh theo giá trị px cụ thể user yêu cầu (ví dụ 16.5px) để chốt đúng tỷ lệ thị giác.
- Với tinh chỉnh nhịp dọc cột giờ ca, cho phép chỉnh `gap` rất nhỏ (ví dụ 8px -> 7px) để đạt mật độ hiển thị user mong muốn.
- Cột `Ghi chú` ở trang `Lịch đã xếp` phải hỗ trợ nhập/sửa trực tiếp bằng textarea và lưu DB theo từng lịch; tránh hiển thị placeholder tĩnh kiểu `-` khi nghiệp vụ cần cập nhật nội dung.
- Thông báo kiểm tra thiếu nhu cầu phải hiển thị rõ tên ca cho cả nhu cầu động (ví dụ `Chích ngoài` tạo runtime), không để trống phần `ca`.
- Với chế độ kéo-thả vận hành linh hoạt, cho phép để trống tất cả ca (không coi là lỗi thiếu người); thay vào đó chỉ chặn các vi phạm cứng như trùng ca/ngày, sai chi nhánh, hoặc vượt giới hạn số người/ca.
- Giới hạn số người theo ca khi kéo-thả: tối đa 2 nhân viên cho mỗi tổ hợp `(ngày, chi nhánh, ca)`; backend phải chuẩn hóa và kiểm tra để ngăn lưu vượt mức.
- Để tránh lỗi "nhảy dòng/nhảy ca" khi kéo card ở ca đầu, bảng lịch chi nhánh phải kéo-thả theo lane ca (drop-zone riêng từng ca), không dùng một danh sách card chung cho cả ô ngày.
- Payload lưu kéo-thả cho nhóm chi nhánh phải gửi rõ `ca_id` theo lane đích; `thu_tu` chỉ dùng để sắp vị trí trong lane và fallback tương thích dữ liệu cũ.
- Với lane ca có tối đa 2 người, UI nên hiển thị 2 card nằm ngang (chia đôi bề ngang); khi chỉ còn 1 card sau thao tác kéo thì card còn lại tự động giãn full-width ngay không cần lưu.
- Với nhóm có lane ca (326/197/796/CN), chỉ cho phép drop vào đúng `ca-lane`; không cho thả vào vùng trống của cả ô ngày để tránh phát sinh "dòng ảo" vượt số ca.
- Với bộ chọn theme dạng dock, dùng `fixed` chỉ khi user muốn dock nổi; nếu user muốn chỉ thấy ở cuối trang thì chuyển về in-flow (`static`) và đặt ở footer area.
- Với ô `Ngày bắt đầu (thứ Hai)` trên trang chủ, mặc định nên là **thứ Hai tiếp theo** so với ngày hiện tại (strict next Monday), trừ khi user truyền ngày rõ ràng hoặc đang mở lịch theo `lich_tuan_id`.
- Nếu user báo "đã sửa nhưng giao diện chưa đổi", ưu tiên xác nhận lại bằng `docker compose up -d --build` và yêu cầu hard refresh để loại trừ cache/container cũ.
