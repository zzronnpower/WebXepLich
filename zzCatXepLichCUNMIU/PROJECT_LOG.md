# Project Log

## Summary of Changes (to date)

- Added `AGENTS.md` with build/run guidance, coding conventions, and repo map.
- Introduced WSL-friendly ops helpers:
  - Added `.env.example` and `Makefile` for `docker-up`, logs, reset DB.
  - Expanded `README.md` with WSL notes and local run steps.
- Fixed scheduling and Excel issues:
  - Corrected CP-SAT literal boolean check in `solver.py`.
  - Excel headers now use Vietnamese diacritics.
  - Improved schedule table text contrast; employee names are black and bold.
- Added consolidated management UI:
  - New `/quan-ly` page to add/update employees, edit priority weights, and run scheduling.
  - Added employee update endpoint and forms for quick updates.
- Updated UI labels across templates to Vietnamese with diacritics.
- Added display mappings for weight keys and group names:
  - Weight keys now show Vietnamese labels in UI tables.
  - Group name `CN` displays as “Chích ngoài” in the schedule table and Excel.
- Updated labels in weights form placeholders to Vietnamese.
- Standardized doctor role/cap_do display strings to “Bác sỹ”.
- Updated dropdown labels for employee level to “Bác sỹ mới/chính”.
- Solver now treats “Bác sỹ chính” as senior for priority scoring.
- Added auto-generated employee codes (BSxx) when adding staff.
- Redesigned add-employee form layout for a cleaner grid layout.
- Added auto-fill and compact layout for the employee update form.
- Added auto-fill support on the /nhan-vien page using a quick select list.
- Documented autofill/form layout conventions in AGENTS.md with HTML/JS examples.
- Added per-employee weight preferences (up to 3) with priority multipliers.
- Updated forms to capture weight preferences and autofill them in edit flows.
- Added delete action for weight definitions on /trong-so and /quan-ly.
- Weight values now come from the weight definitions (no manual entry per employee).
- Weight definitions now support inline value edits in the tables.
- Weight selectors now display current weight values inline.
- Weight value inputs now use dropdowns (1-5) instead of free number input.
- Badge hints simplified to show only the level indicator.
- Fixed badge hints to update per select without extra label text.
- Added schedule validation page (/kiem-tra) to auto-check constraints.
- Auto-generate shift demands for new weeks by copying the latest week.
- Preserve selected week date on scheduling errors.
- Added /thu-nghiem to compare optimization scores across weight scenarios.
- Added drag-and-drop schedule editing with save to DB.
- Save action now returns constraint checks and shows yellow warning on blocking errors.
- Error messages now include staff name, branch, and shift details for duplicate assignments.
- Constraint check now includes chích ngoài demand when saving drag-and-drop.
- Drag-and-drop saving now reports connection errors and prevents text selection.
- Saving drag-and-drop now returns structured errors instead of fetch failures.
- Release v1.0.0 created: version đầu tiên chạy stable ngày 25/01/2026.
- Renamed Spa group to OFF (Ngày nghỉ) and auto-migrate existing data on startup.
- Added OFF auto-fill for unassigned staff after scheduling and integrated OFF day input + sorting UI.
- Enforced default demands for 9h-20h and 10h-21h shifts at 326TTV and 197LT5 when missing.
- Aligned OFF overview columns with schedule table and added week-only OFF list layout.
- Added logo header for Phòng Khám Thú Y Cún Miu and tightened header spacing.
- Added "Top" (7) weight level, restored per-row edits on /trong-so, and locked edits in /quan-ly.
- Added "Không đi chích ngoài" soft penalty and auto-ensure weight in DB on startup.
- Enhanced staff screens with multi-select toggles and visible lists for preferred/avoid shifts and branches.
- Added global theme switcher with 3 themes:
  - Default (existing dark style)
  - Pinky (warm beige/pink)
  - Light Green (sage/olive)
- Implemented theme engine at `backend/app/static/theme.js` with localStorage persistence.
- Added theme token overrides in `backend/app/static/style.css` and floating selector dock.
- Wired theme script in `backend/app/templates/base.html` so all pages share the same theme selection.

## Latest Update (2026-02-23)

- Added schedule editing and management enhancements:
  - New page `/lich-da-xep` to list all schedule runs and reopen any week for editing.
  - Main schedule page now links directly to schedule history management.
- Added ChatLog page:
  - New route `/chatlog` and template `backend/app/templates/chatlog.html`.
  - Added ChatLog link in global navigation.
- Updated system groups and display flow:
  - Added `PHU_SPA` group (manual-only zone, ca hiển thị `8h30-19h30`, no branch mapping).
  - Added `CHUA_XEP` group so unassigned staff are no longer auto-converted to OFF.
  - Group order now renders as: 326TTV, 197LT5, 796ADV, Chích ngoài, Phụ Spa, OFF, Chưa xếp.
- Drag-drop UX and constraints improved on weekly schedule table:
  - Vertical-only drag/drop (same date only), horizontal drag blocked.
  - Supports insert at top/middle/bottom with visual drop indicator.
  - Fixed reverse reorder behavior (drag from below to above).
  - Added per-item ordering support (`lich_chi_tiet.thu_tu`) for stable rendering.
- OFF lock behavior implemented:
  - OFF created from real leave registration (`NgayNghi`) is now hard-locked (frontend + backend validation).
  - Locked OFF cards use a dedicated highlight color in OFF area.
- Visual polish updates:
  - Shift labels are larger, better spaced, and align more cleanly with assignment cards.
- Maintenance rule added:
  - `AGENTS.md` now requires automatic updates of `chatlog.html`, `AGENTS.md`, and `PROJECT_LOG.md` after each coding task.

## Latest Update (2026-02-23, follow-up)

- Replaced hard OFF lock with user-controlled toggle on schedule board:
  - Added `Khóa NV OFF` toggle button next to `Kiểm tra ràng buộc`.
  - Toggle ON: registered OFF staff are non-draggable.
  - Toggle OFF: all staff can be dragged normally.
  - Toggle state is persisted in browser localStorage and passed to `/cap-nhat-lich` payload.
- Updated backend save validation to respect toggle state:
  - OFF lock checks now apply only when `khoa_nv_off = true`.
  - Vertical-only drag rule remains enforced.
- Fixed action button overlap on `Lịch đã xếp`:
  - Wrapped action links into a dedicated flex container with wrapping + spacing.
  - Added action column width and no-wrap button text styling for clean alignment.

## Latest Update (2026-02-23, UI alignment follow-up)

- Refined `Nhóm / Ca` readability on weekly schedule table:
  - Shift labels are now rendered as dedicated chips (`.ca-chip`) instead of plain text lines.
  - Increased shift text visual weight/size and spacing so row rhythm aligns better with employee cards.
  - Improved group title typography to better match the assignment column.
- Hardened `Lịch đã xếp` action layout to eliminate overlap:
  - Increased action column width and prevented button shrinking.
  - Forced one-line action buttons with nowrap and no-flex-shrink behavior.
  - Enabled horizontal overflow safety via wider table min-width.

## Latest Update (2026-02-23, hotfix visual regression)

- Fixed schedule table left column shift labels so they no longer look like tiny plain text:
  - Shift lines now reuse card visual language (`the-nv ca-chip`) for clearer alignment with assigned staff cards.
  - Updated chip typography and spacing to match row rhythm.
- Reworked `Lịch đã xếp` action column with deterministic layout:
  - Added fixed column widths via `colgroup`.
  - Switched action container to 3-column grid (`Mở & chỉnh sửa`, `Kiểm tra`, `Excel`).
  - Prevented per-button text wrap/shrink and increased table min-width for stable rendering.

## Latest Update (2026-02-23, alignment + color follow-up)

- Adjusted left column alignment across all branches/groups so assignment cards visually align with group label lane:
  - Increased and stabilized `ten-nhom` label lane (`min-height`, flex alignment).
  - Shift list (`ds-ca`) is clearly pushed below label lane to avoid blending with employee row 1.
- Applied exact branch-row background feel for shift chips:
  - `ca-chip` now uses transparent background (same as parent row color), no separate chip fill.
- Strengthened action-button anti-overlap rules on `Lịch đã xếp`:
  - Enforced `white-space: nowrap !important` and `flex-shrink: 0` on action buttons.

## Current State

- Docker app is running under WSL; port conflicts previously resolved by removing orphan containers.
- Scheduling output displays in the weekly table; if blank, verify `lich_chi_tiet` rows in DB.
- Data is seeded on first startup; reset DB with `docker compose down -v` to re-seed.

## Latest Requested Changes (pending DB reset)

- Added employee-to-branch restrictions (new `nhan_vien_chi_nhanh` join table).
- UI now supports selecting allowed branches per employee.
- Renamed branches/groups to:
  - `326TTV`, `197LT5`, `796ADV`.
- Seed data updated to new doctors list:
  - Bác sĩ chính: Hữu, Nhựt, Hồng, Thy
  - Bác sĩ mới: Thùy, My, Hà, Đạt, Hiếu, Phong, Đăng
  - Branch restrictions: Hữu -> 326, Nhựt -> 197, Đăng -> 796

## To Apply Schema + Seed Updates

```bash
sudo docker compose down -v
sudo docker compose up -d --build
```

This will wipe existing data and re-seed the updated dataset.

## Latest Update (2026-02-23, row alignment fix)

- Fixed row alignment between shift times and employee cards on weekly schedule board:
  - Applied a shared lane offset with CSS variable `--lane-nhom-ca` on `.bang-lich`.
  - Added `padding-top: var(--lane-nhom-ca)` to `.o-lich` so first employee card starts at the same vertical level as first shift line.
- Root-cause and layout rule:
  - Root-cause was asymmetric vertical offsets: left column had `ten-nhom` lane (`min-height + margin`) plus `ds-ca` top gap, while assignment cells started at top with no equivalent offset.
  - New rule enforces symmetric lane spacing between "Nhóm / Ca" and assignment columns to prevent one-line upward drift.

## Latest Update (2026-02-23, OFF lock source rule)

- Updated OFF lock behavior to target only user-registered leave records:
  - Lock set now includes only `ngay_nghi` rows with `trang_thai='OFF'` and source from user (`nguon='user'`, with backward-compatible fallback for old null values).
  - OFF cards created by scheduling/manual drag without matching user leave registration remain draggable even when `Khóa NV OFF` is ON.
- Data model hardening:
  - Added `ngay_nghi.nguon` column with startup migration (`ALTER TABLE ... ADD COLUMN IF NOT EXISTS`) and backfill for null/empty values to `user`.
  - New leave entries from UI now persist `nguon='user'` explicitly.

## Latest Update (2026-02-23, scheduling OFF vs CHUA_XEP rule)

- Updated weekly scheduler output behavior:
  - OFF now represents only registered leave entries (`ngay_nghi.trang_thai='OFF'`).
  - Any staff/day not assigned by solver and not in registered leave is placed into `CHUA_XEP` for manual review/drag-drop assignment.
- Removed fallback that previously sent unassigned staff to OFF when `CHUA_XEP` was missing:
  - Scheduler now auto-creates `CHUA_XEP` group if absent, then routes unassigned staff there.
- Added safety normalization on schedule creation:
  - If any generated OFF row does not match registered leave set, it is auto-moved to `CHUA_XEP` in the same run.

## Latest Update (2026-02-23, manual-first scheduling button)

- Added new action button `Tự xếp lịch` next to `XẾP LỊCH` on home page.
- Added backend route `/tu-xep-lich` and new scheduler flow to create a manual-first weekly board:
  - Staff with registered leave are placed in `OFF` on the exact leave dates.
  - All remaining staff/day entries are placed in `CHUA_XEP` for manual drag-drop assignment.
  - No branch/shift auto-assignment is created in this mode (`chi_nhanh_id` and `ca_id` remain null).

## Latest Update (2026-02-23, button visual adjustment)

- Updated the `Tự xếp lịch` button visual treatment on the home form:
  - Switched to the same primary button sizing as `XẾP LỊCH`.
  - Applied dark green background (`.nut-tu-xep`) for clearer manual-first action distinction.

## Latest Update (2026-02-23, schedule history management)

- Added rename/delete management for saved schedules at `/lich-da-xep`:
  - Inline rename form per row (save display title directly on schedule run).
  - Delete action per row with confirmation prompt, removing the selected schedule run.
- Data model and migration:
  - Added `lich_tuan.ten_lich` column for explicit schedule naming.
  - Added startup migration/backfill for existing rows, generating default names from status + start date.
- UX/layout updates in schedule history table:
  - Added `Tên lịch` column.
  - Expanded action column/grid to include the new `Xóa` button without overlap.

## Latest Update (2026-02-23, SPA OFF temporary note area)

- Added a separate `SPA OFF` section below the main schedule board (visually detached with spacing and dashed container).
- For each day column in the current week, added one multiline textarea for operator notes.
- This area is intentionally non-persistent:
  - no API call,
  - no DB write,
  - no localStorage save,
  - content is temporary and resets on page reload.

## Latest Update (2026-02-23, drag-save shift mapping fix for TU_XEP)

- Fixed a critical mismatch between drag-drop UI and constraint validation in manual-first schedules (`TU_XEP`):
  - Root-cause: after drag-drop, rows in branch groups updated only `nhom_hien_thi_id`/`thu_tu` while `ca_id` and `chi_nhanh_id` could remain null.
  - Impact: `kiem_tra_lich` counted assignments by `(ngay, ca_id, chi_nhanh_id)` and reported mass false shortages.
- Implemented save-time remapping in `/cap-nhat-lich`:
  - For non-free groups, map `thu_tu` to shift (`ca_id`) using configured `danh_sach_ca_theo_nhom` order.
  - Resolve `chi_nhanh_id` from `(nhom_hien_thi_id, ca_id)` via `mapping_nhom`.
  - Persist both `ca_id` and `chi_nhanh_id` immediately so validation reads real assignment state.

## Latest Update (2026-02-23, schedule action toolbar placement)

- Moved all schedule action controls into a separate toolbar above the `Bảng lịch hiển thị` title:
  - `Quản lý lịch đã xếp`, `Tải Excel`, `Kiểm tra ràng buộc`, `Khóa NV OFF`, `Tắt tô sáng`, `Lưu kéo thả`.
- Added dedicated layout class `thanh-hanh-dong-lich` (flex-wrap + spacing) to keep controls detached and cleaner from the table heading area.
- Kept button ids and existing JS behavior unchanged, so interaction logic remains stable.

## Latest Update (2026-02-23, conversation-style chatlog + header polish)

- Updated chat history page to conversation-style layout similar to Boktoshi:
  - Replaced tile-grid feel with vertical chat bubbles.
  - Alternating bubble alignment/colors for User vs Assistant for better readability.
  - Preserved existing transcript content; only presentation changed.
- Updated home schedule section title to:
  - `Bảng xếp lịch làm việc Phòng Khám Thú Y Cún Miu`.
- Updated schedule action toolbar button visual:
  - Light pink background + bold text for stronger visual emphasis.

## Latest Update (2026-02-23, toolbar color adjustment)

- Adjusted schedule action toolbar button theme from light pink to light yellow based on UX preference.
- Updated paired border/text/hover colors to keep contrast readable on the existing page background.

## Latest Update (2026-02-23, shift label typography fine-tune)

- Adjusted shift-time label font size in schedule left column:
  - `.ca-chip` font-size changed from `18px` to `16.5px`.
- Goal: keep shift text visually closer to employee name size and reduce oversized appearance.

## Latest Update (2026-02-23, shift row spacing fine-tune)

- Adjusted vertical spacing between shift-time rows in left column:
  - `.ds-ca` `gap` changed from `8px` to `7px`.
- Goal: tighten spacing slightly while keeping readability.

## Latest Update (2026-02-23, editable notes in schedule history)

- Upgraded `Ghi chú` column on `/lich-da-xep` from static text (`-`) to editable per-row form:
  - Added `textarea` input and `Lưu ghi chú` action for each schedule row.
  - Existing note value is prefilled for quick edits.
- Added backend persistence endpoint:
  - `POST /lich-da-xep/{lich_tuan_id}/ghi-chu`
  - Saves form value into `lich_tuan.ghi_chu` (empty text normalized to null).
- Updated table layout sizing to accommodate note editor without action overlap.

## Latest Update (2026-02-23, theme selector footer behavior)

- Changed theme selector dock behavior from floating to in-flow footer placement:
  - `.theme-dock` switched from `position: fixed` to `position: static`.
  - Added footer-like margin so it stays near page bottom.
- Result:
  - Theme selector is no longer always visible during scroll at top/middle content.
  - It appears naturally when user scrolls toward the bottom of the page.

## Latest Update (2026-02-23, default start date to next Monday)

- Updated default value logic for `Ngày bắt đầu (thứ Hai)` on home page:
  - Added helper to compute the **next Monday** relative to current date.
  - Rule is strict "next" Monday (if today is Monday, default becomes Monday next week).
- Applied in home-page default branch and invalid leave-input fallback renders so the date picker remains consistent after validation errors.

## Latest Update (2026-02-24, SPA OFF notes persisted per schedule/day)

- Upgraded `SPA OFF` note area from temporary-only to persisted storage by schedule week:
  - Added new DB field `lich_tuan.spa_off_ghi_chu` (JSON text) with startup migration.
  - Stored as `{ "YYYY-MM-DD": "note text" }` for day-level mapping.
- Weekly board now preloads SPA OFF notes for the currently opened schedule:
  - `lay_lich_hien_thi` parses persisted JSON and maps notes back to each day column.
  - Textareas in SPA OFF section are prefilled correctly when reopening any saved schedule.
- Extended save payload and backend endpoint `/cap-nhat-lich`:
  - Frontend now sends `spa_off_notes` together with drag-drop changes.
  - Backend accepts note-only saves (without drag changes), validates week dates, and persists per-day notes to `lich_tuan`.

## Latest Update (2026-02-24, 796ADV/CN constraint-check normalization hardening)

- Hardened save-time normalization in `/cap-nhat-lich` for branch groups:
  - After applying incoming drag changes, backend now re-normalizes **all** rows in the schedule snapshot (`du_kien`) for non-free groups, mapping `thu_tu` -> `ca_id` and `(nhom, ca)` -> `chi_nhanh_id`.
  - Prevents stale legacy rows (especially in `796ADV` / `CN`) from keeping `ca_id`/`chi_nhanh_id` as null and causing false shortage errors.
- Improved constraint-check error text in `kiem_tra_lich`:
  - For runtime-generated demands (e.g. `Chích ngoài`), ca name is now resolved via `ca_id` fallback map when ORM relation is missing.
  - Error messages no longer show blank `ca` suffix.

## Latest Update (2026-02-24, flexible empty shifts + up to 2 staff per shift)

- Updated schedule validation policy for manual drag-drop operation:
  - Removed blocking "Thiếu người" errors from `kiem_tra_lich` so all shifts can be left empty without failing constraint checks.
  - Added hard cap check: each `(ngày, chi nhánh, ca)` now allows at most 2 staff; exceeding this returns validation error.
- Upgraded save-time shift mapping in `/cap-nhat-lich` to support 2 staff per shift:
  - Introduced slot mapping rule with 2 vertical positions per shift (`thu_tu` 1-2 => ca #1, 3-4 => ca #2, ...).
  - Backend now maps `thu_tu` to `ca_id` using this 2-slot-per-shift rule and blocks out-of-range placements.
- UI guidance enhancement on home schedule board:
  - Added helper note under title to explain drag-drop interpretation: max 2 staff/shift and ordering behavior by vertical position.

## Latest Update (2026-02-24, lane-based drag/drop hotfix for multi-staff shifts)

- Fixed drag/drop behavior regression that caused slot jumping across shifts:
  - Root-cause: frontend was still reordering one flat card list per day-cell while backend interpreted order as 2-slot-per-shift mapping.
  - Impact: moving a card out of `8h-19h` could shift lower cards upward and remap their ca unexpectedly.
- Implemented lane-based drag/drop in weekly board:
  - Branch groups now render dedicated drop lanes per shift (`ca-lane`) and cards are dragged within/across lanes on same day.
  - Each lane is capped at 2 cards on UI side.
- Save payload + backend mapping hardening:
  - Frontend now sends explicit `ca_id` for changed cards.
  - Backend `/cap-nhat-lich` prioritizes incoming `ca_id` (with strict group validation), then falls back to legacy `thu_tu` mapping only when needed.
  - Added save-time hard cap check to reject >2 staff for any `(ngày, chi nhánh, ca)`.

## Latest Update (2026-02-24, side-by-side cards for 2 staff in same shift)

- Improved shift-lane visual layout for dual staffing:
  - `.ca-lane` switched to wrapped flex layout with two equal-width slots.
  - When a lane has 2 staff, cards render side-by-side (50/50 width).
  - When one staff is dragged away, remaining card auto-expands to full width via `:only-child` (no save/reload needed).

## Latest Update (2026-02-24, prevent extra phantom rows in branch lanes)

- Fixed drag target validation for lane-based cells:
  - For groups with shift lanes (`326TTV`, `197LT5`, `796ADV`, `CN`), drop is now accepted only when pointer is inside a `.ca-lane`.
  - Dropping into blank area of the parent day-cell is rejected, preventing creation of visual "row 5/row 4" beyond configured shift count.
- Added event propagation guard on dragover/drop (`stopPropagation`) to avoid parent `.o-lich` handler re-processing lane drops.

## Latest Update (2026-02-25, allow save with branch-profile violation)

- Updated drag-save behavior in `/cap-nhat-lich` for employee-branch profile mismatch:
  - Rule `Nhân viên không thuộc chi nhánh` no longer blocks save/commit in drag-drop flow.
  - Schedule changes are persisted first, then violation is returned in response `errors[]` so UI still warns users.
- Extended post-save validation (`kiem_tra_lich`) with branch-profile check:
  - Detects assignments where `nhan_vien.chi_nhanh` does not contain assigned `chi_nhanh_id`.
  - Adds explicit violation message including employee name, branch name, and date for traceability.
- Outcome:
  - Manual operations can continue even with intentional cross-branch assignment.
  - System still reports the violation clearly instead of silently ignoring it.

## Latest Update (2026-02-25, auto screenshot download on save)

- Updated weekly board save action UI:
  - Renamed button label from `Lưu kéo thả` to `Lưu Lịch Đã Xếp`.
- Added automatic screenshot export right after successful save:
  - Frontend loads `html2canvas` and captures a cropped region from schedule title `Bảng xếp lịch làm việc Phòng Khám Thú Y Cún Miu` down to the bottom of the `OFF` row.
  - Triggered immediately after `/cap-nhat-lich` returns `ok=true` (both normal save and save-with-constraint-warnings).
  - Auto-downloads PNG file to user machine with date-stamped filename.
- UX behavior:
  - Save flow remains unchanged for DB persistence.
  - If screenshot succeeds, success/warning toast includes `Đã tải ảnh`.
  - If screenshot fails, save is still kept and toast clearly states image download failed.

## Latest Update (2026-02-25, screenshot scope fix + top result banner)

- Fixed screenshot target selection on weekly board save:
  - Root-cause: selector used `.bang-lich table` and matched the first table (`Ngày nghỉ đã nhập`) instead of the schedule board.
  - Added dedicated schedule table id `#bang-lich-chinh` and scoped OFF-row lookup inside that table.
  - Screenshot crop now consistently uses schedule title -> bottom of OFF row in the intended board.
- Moved save/check result message to top operation area:
  - Added unified banner in hero section with fixed label `Kết quả thao tác lưu/kiểm tra:`.
  - Save success/warning/error text now fills the banner content instead of rendering below schedule title.
  - Kept existing save + auto-download behavior unchanged.

## Latest Update (2026-02-25, separate action panel + screenshot wrapper capture)

- Split schedule action controls into a dedicated panel:
  - Moved `Quản lý lịch đã xếp / Tải Excel / Kiểm tra ràng buộc / Khóa NV OFF / Tắt tô sáng / Lưu Lịch Đã Xếp` into its own `section.khung`.
  - Schedule board section now focuses on title + board content only, matching the same separation style as other blocks like `Ngày nghỉ đã nhập`.
- Refined screenshot capture pipeline to avoid toolbar leakage:
  - Added wrapper `#vung-chup-bang-lich` and render screenshot from this wrapper instead of full `document.body`.
  - Cropping is computed inside wrapper coordinates: top at schedule title and bottom at OFF-row edge.
  - Result excludes the action-toolbar panel above while keeping expected schedule area.

## Latest Update (2026-02-25, screenshot pinky background + persistent save banner)

- Fixed black background in downloaded screenshot on light themes (notably Pinky):
  - Export now resolves background color from the current schedule panel (`.khung`) and passes it to `html2canvas.backgroundColor`.
  - Prevents transparent regions from rendering as black in PNG viewers.
- Changed save UX so operation result remains readable:
  - Removed automatic `window.location.reload()` after successful save.
  - Banner `Kết quả thao tác lưu/kiểm tra:` now stays visible until the next save/check updates it.
  - Existing behavior of replacing old message with the latest result is preserved.

## Latest Update (2026-02-25, always screenshot on failed save + notes relocation)

- Updated drag-save feedback flow on homepage (`index.html`):
  - Screenshot download now runs for every `/cap-nhat-lich` response, including `ok=false` (save blocked).
  - When save is blocked, banner still reports save error and appends screenshot status (`Đã tải ảnh` / `Chưa tải được ảnh`).
- Repositioned operational hint text for better visibility:
  - Removed inline hint above schedule table area.
  - Added a dedicated line under top result banner with label `Notes:` and content about max 2 staff per shift + correct lane drop target.

## Latest Update (2026-02-25, centered board title + live color picker)

- Centered the weekly board heading block:
  - `Bảng xếp lịch làm việc Phòng Khám Thú Y Cún Miu` is now centered in the schedule area for clearer visual focus.
- Added on-page color customization for schedule board identity:
  - New toolbar color controls: `Màu tiêu đề`, `Màu chữ thứ`, `Màu nền thứ`.
  - Colors are applied via CSS variables (`--mau-tieu-de-bang-lich`, `--mau-chu-thu-bang-lich`, `--mau-nen-thu-bang-lich`) so updates are instant.
  - Selected colors persist per browser via `localStorage` (`xeplich_mau_tieu_de_bang`, `xeplich_mau_chu_thu_bang`, `xeplich_mau_nen_thu_bang`).
- Screenshot consistency:
  - Existing `html2canvas` flow remains unchanged but now captures the board with user-selected colors exactly as rendered on screen.

## Latest Update (2026-02-25, single color picker + explicit apply action)

- Simplified color customization UX on schedule toolbar:
  - Replaced 3 separate pickers with one unified color picker `Màu tiêu đề + thứ`.
  - Added explicit `Áp dụng` button next to picker; color changes only when clicking this button.
- Applied color scope:
  - The chosen color now controls both schedule title (`Bảng xếp lịch...`) and text color of weekday/date headers in `#bang-lich-chinh thead th`.
  - Header background color customization was removed to match user request for a single-color flow.
- Persistence and screenshot behavior:
  - Selected/applied color is stored in browser `localStorage` key `xeplich_mau_tieu_de_va_thu`.
  - Save + screenshot flow keeps capturing the currently applied color exactly as displayed.

## Latest Update (2026-02-25, force-apply title/header color to avoid theme/cache override)

- Hardened color apply action for schedule board styling:
  - Root-cause observed in operation: in some sessions, CSS variable update was not visibly reflected after clicking `Áp dụng` (likely stale CSS/theme precedence/cache).
  - Updated `apDungMauBang(...)` to apply color in two layers:
    1) keep writing CSS vars (`--mau-tieu-de-bang-lich`, `--mau-chu-thu-bang-lich`), and
    2) set inline style directly on `#tieu-de-bang-xep-lich` and all `#bang-lich-chinh thead th`.
- Outcome:
  - Click `Áp dụng` now gives immediate visible color change for both target texts.
  - Screenshot after save remains consistent because rendered DOM already has the inline/applied color.

## Latest Update (2026-02-25, draft-first scheduling + leave-page save/discard confirm)

- Changed schedule generation flow to draft-first:
  - `POST /xep-lich` and `POST /tu-xep-lich` now still generate schedule records for editing, but they are marked as draft status (`NHAP_DA_XEP` / `NHAP_TU_XEP`) right after creation.
  - Draft schedules are excluded from default latest-schedule fallback and from `Lịch đã xếp` listing (`danh_sach_lich_tuan` filters out `NHAP_%`).
- Added explicit draft lifecycle APIs:
  - `POST /lich-nhap/luu`: finalize draft status to official (`DA_XEP` or `TU_XEP`).
  - `POST /lich-nhap/huy`: delete draft schedule (cascade removes details).
  - `POST /cap-nhat-lich` now auto-finalizes draft status when save succeeds, and also supports finalize-only (no drag changes) for draft records.
- Added frontend leave-page guard for draft schedule on homepage:
  - Shows top warning banner when current schedule is draft.
  - Intercepts in-app link/form navigation and prompts: OK = save draft, Cancel = discard draft.
  - Uses browser native `beforeunload` warning for close/reload while draft is unsaved.
  - Uses `pagehide + sendBeacon('/lich-nhap/huy')` to best-effort discard draft if user leaves without explicit save.

## Latest Update (2026-02-25, exclude save-download links from draft leave guard)

- Fixed false prompt when clicking `Lưu Lịch Đã Xếp` in draft mode:
  - Root-cause: leave-page click guard intercepted generated `<a>` download link used by screenshot auto-download and treated it as page navigation.
  - Updated guard filter to ignore non-navigation links: `download` attribute, `href` starting with `data:`/`blob:`, and `target="_blank"`.
- Outcome:
  - Saving schedule no longer triggers the leave-page confirm popup.
  - Draft confirm behavior is preserved for actual in-app navigation away from the page.

## Latest Update (2026-02-25, windows handover scripts + full DB transfer guide)

- Added Windows deployment helper scripts:
  - `scripts/windows_setup_and_restore.ps1`: one command to run `docker compose up -d --build`, optionally restore `.sql`/`.sql.gz` dump into Postgres container, then restart web.
  - `scripts/windows_setup_and_restore.bat`: thin wrapper to call the PowerShell script for users who prefer double-click / `.bat` workflow.
- Updated README handover instructions:
  - Clarified runtime URL for current compose mapping (`http://localhost:8001`).
  - Added source-machine dump steps and target Windows restore flow with exact commands.
- Operational output for current handover:
  - Generated full database dump artifact at `backups/lich_dump_v1.1_20260225_121102.sql.gz`.
  - SHA256: `00ddbc4b56ad13302bddadb99c4a44902bb5fe649a258993d210d9c216c56a11`.
