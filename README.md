# academic-writer

AI-assisted academic document writing system สำหรับนักวิจัย
ทำงานร่วมกับ Claude Code ใน Positron

## Install

```bash
git clone https://github.com/datakruroo/academic-writer
cd academic-writer
bash install.sh
```

## สร้าง project ใหม่

```bash
new-doc article  my-study
new-doc proposal climate-project
new-doc policy   data-governance
new-doc report   annual-research
```

## Workflow

```bash
cd my-study
# 1. กรอก intent.md
# 2. เปิด Positron แล้วเริ่มใน terminal:
claude "draft outline"
claude "expand introduction"
claude "embed analysis from analysis/main.R"
claude "review consistency"
quarto render draft.qmd --to html
```

## Dependencies

- Claude Code (claude CLI)
- Quarto
- Positron + Quarto extension
- R หรือ Python (สำหรับ analysis chunks)
