# academic-writer

ระบบช่วยเขียนเอกสารวิชาการด้วย AI สำหรับนักวิจัยสาขาวิทยาการข้อมูลทางการศึกษา

- **Hermes (OpenRouter)** — intake: สัมภาษณ์รับความต้องการและเขียน `intent.md` อัตโนมัติ
- **Claude Code / OpenAI Codex** — writing: ยกร่างและแก้ไขเอกสารจาก `intent.md`

---

## ติดตั้ง

```bash
git clone https://github.com/datakruroo/academic-writer
cd academic-writer
pip install -r requirements.txt
bash install.sh
```

ตั้งค่า API key สำหรับ Hermes:

```bash
export OPENROUTER_API_KEY=sk-or-...
# เพิ่มใน ~/.zshrc หรือ ~/.bashrc เพื่อให้ถาวร
```

---

## โครงสร้าง repo

```
academic-writer/
├── system.md          ← กฎ สไตล์ และ workflow สำหรับ writing agent
├── skills/
│   └── intake.md      ← system prompt ของ Hermes intake (แก้ได้โดยไม่ต้องเขียน Python)
├── templates/         ← intent.md template เปล่าสำหรับ new-doc
├── scripts/
│   ├── new-doc        ← สร้าง project + template intent.md เปล่า
│   ├── aw             ← runner สำหรับ Hermes skills
│   └── new-doc-intake ← (legacy) intake แบบ Python chatbot
└── install.sh
```

---

## ประเภทเอกสาร

| type | คำอธิบาย |
|---|---|
| `article` | บทความวิจัย |
| `proposal` | โครงร่างวิจัย |
| `policy` | เอกสารนโยบาย |
| `report` | รายงานการวิจัย |

---

## สร้าง project ใหม่

### วิธีที่ 1 — ให้ Hermes สัมภาษณ์และเขียน intent.md ให้ (แนะนำ)

```bash
aw intake article my-study
```

Hermes จะสัมภาษณ์ทีละขั้น เมื่อข้อมูลครบจะเรียก `write_file` เขียน `intent.md` ลง project folder โดยตรง แสดง preview และรอยืนยันก่อนจบ ถ้าไม่พอใจคุยต่อได้เลย

**เปลี่ยน model:**
```bash
export OPENROUTER_MODEL=nousresearch/hermes-3-llama-3.1-405b
aw intake proposal climate-project
```

### วิธีที่ 2 — กรอก intent.md เอง

```bash
new-doc article my-study
cd my-study
# แก้ไข intent.md ให้ครบ แล้วเริ่มเขียน
```

---

## โครงสร้าง project ที่สร้างขึ้น

```
my-study/
├── intent.md        ← thesis, claims, constraints (กรอกก่อนทุกครั้ง)
├── draft.qmd        ← Quarto document ที่ writing agent จะเขียนลงมา
├── CLAUDE.md        ← context สำหรับ Claude Code
├── AGENTS.md        ← context สำหรับ OpenAI Codex
├── references/      ← ใส่ PDF ที่ต้องอ้างอิง
└── analysis/        ← ใส่ R/Python scripts
```

---

## เขียนเอกสาร

### Claude Code

```bash
cd my-study
claude "draft outline"
claude "expand introduction"
claude "expand method"
claude "embed analysis from analysis/main.R"
claude "review consistency"
```

### OpenAI Codex

```bash
cd my-study
codex "draft outline"
codex "expand introduction"
```

### Render

```bash
quarto render draft.qmd --to html
quarto render draft.qmd --to pdf
```

---

## คำสั่งที่ writing agent เข้าใจ

| คำสั่ง | สิ่งที่เกิดขึ้น |
|---|---|
| `draft outline` | สร้าง skeleton headings ใน draft.qmd |
| `expand [section]` | เขียน prose ใน section ที่ระบุ |
| `embed analysis from [file]` | แปลง R/Python script เป็น code chunk |
| `review consistency` | ตรวจว่า draft ตรงกับ thesis และ key_claims |
| `review argument` | ตรวจว่า claim มี evidence support ครบ |

---

## เพิ่ม skill ใหม่

สร้างไฟล์ใน `skills/` แล้วเรียกผ่าน `aw`:

```bash
# สร้าง skills/review.md แล้วเรียกว่า:
aw review article my-study
```

---

## Dependencies

- Python 3.8+ และ `pip install -r requirements.txt`
- [Claude Code](https://claude.ai/code) — สำหรับ `claude` CLI
- [Quarto](https://quarto.org) — สำหรับ render เอกสาร
- Positron + Quarto extension — IDE แนะนำ
- R หรือ Python — สำหรับ analysis chunks ใน .qmd
- OpenRouter API key — สำหรับ `aw`
