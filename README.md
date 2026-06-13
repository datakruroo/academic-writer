# academic-writer

ระบบช่วยเขียนเอกสารวิชาการด้วย AI สำหรับนักวิจัยสาขาวิทยาการข้อมูลทางการศึกษา

- **Hermes (OpenRouter)** — intake agent: สัมภาษณ์รับความต้องการและสร้าง `intent.md`
- **Claude Code / OpenAI Codex** — writing agent: ยกร่างและแก้ไขเอกสารจาก `intent.md`

---

## ติดตั้ง

```bash
git clone https://github.com/datakruroo/academic-writer
cd academic-writer
pip install -r requirements.txt
bash install.sh
```

ตั้งค่า API key สำหรับ intake agent (ถ้าใช้ `new-doc-intake`):

```bash
export OPENROUTER_API_KEY=sk-or-...
```

เพิ่มบรรทัดนี้ใน `~/.zshrc` หรือ `~/.bashrc` เพื่อให้ถาวร

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

มีสองวิธีขึ้นอยู่กับว่าต้องการกรอก intent.md เองหรือให้ AI ช่วย

### วิธีที่ 1 — กรอก intent.md เอง

```bash
new-doc article my-study
cd my-study
# แก้ไข intent.md ให้ครบ แล้วเริ่มเขียน
```

`new-doc` จะสร้าง project folder พร้อม `intent.md` ที่เป็น template ว่างๆ ให้กรอกเอง

### วิธีที่ 2 — ให้ Hermes สัมภาษณ์และเขียน intent.md ให้

```bash
new-doc-intake article my-study
```

Hermes จะถามคำถามทีละขั้นจนครบ แล้วสร้าง `intent.md` ให้อัตโนมัติ
ตรวจสอบและแก้ไขผลลัพธ์ก่อนเริ่มเขียนเสมอ

**ตัวเลือกระหว่างสัมภาษณ์:**
- พิมพ์ `สรุป` — ให้ agent generate `intent.md` จากข้อมูลที่มีทันที โดยไม่ต้องรอครบทุก section
- พิมพ์ `quit` — ออกโดยไม่บันทึก

**เปลี่ยน model** (default: `nousresearch/hermes-3-llama-3.1-70b`):

```bash
export OPENROUTER_MODEL=nousresearch/hermes-3-llama-3.1-405b
new-doc-intake proposal climate-project
```

---

## โครงสร้าง project ที่สร้างขึ้น

```
my-study/
├── intent.md        ← กรอกก่อนทุกครั้ง (thesis, claims, constraints)
├── draft.qmd        ← Quarto document ที่ AI จะเขียนลงมา
├── CLAUDE.md        ← context สำหรับ Claude Code
├── AGENTS.md        ← context สำหรับ OpenAI Codex
├── references/      ← ใส่ PDF ที่ต้องอ้างอิง
└── analysis/        ← ใส่ R/Python scripts
```

---

## เขียนเอกสาร

เปิด terminal ใน project folder แล้วเรียก AI tool ที่ต้องการ

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

### Render เป็น HTML / PDF

```bash
quarto render draft.qmd --to html
quarto render draft.qmd --to pdf
```

---

## คำสั่งที่ AI เข้าใจ

| คำสั่ง | สิ่งที่เกิดขึ้น |
|---|---|
| `draft outline` | สร้าง skeleton headings ใน draft.qmd |
| `expand [section]` | เขียน prose ใน section ที่ระบุ |
| `embed analysis from [file]` | แปลง R/Python script เป็น code chunk |
| `review consistency` | ตรวจว่า draft ตรงกับ thesis และ key_claims |
| `review argument` | ตรวจว่า claim มี evidence support ครบ |

---

## Dependencies

- Python 3.8+ และ `pip install -r requirements.txt`
- [Claude Code](https://claude.ai/code) — สำหรับ `claude` CLI
- [Quarto](https://quarto.org) — สำหรับ render เอกสาร
- Positron + Quarto extension — IDE แนะนำ
- R หรือ Python — สำหรับ analysis chunks ใน .qmd
- OpenRouter API key — สำหรับ `new-doc-intake`
