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
