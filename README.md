# 🧹 Real Estate Data Cleaning with MySQL

This project focuses on enhancing data quality by cleaning, structuring, and standardizing a real estate dataset using MySQL.

---

## 📌 Key Objectives

- Import raw dataset into MySQL
- Perform thorough data cleaning operations
- Ensure improved structure and data quality

---

## 🔧 Cleaning Operations Performed

### ✅ 1. Standardized Date Format
- Converted inconsistent date entries into a uniform format.

### ✅ 2. Address Standardization
- Filled missing property addresses.
- Split address into structured columns: `Address`, `City`.

### ✅ 3. Owner Address Enhancement
- Separated owner address into: `Address`, `City`, `State`.

### ✅ 4. Categorical Value Cleanup
- Replaced `'Y'`/`'N'` with `'Yes'`/`'No'` in the `Sold As Vacant` column.

### ✅ 5. Data Deduplication
- Removed duplicate records to ensure dataset accuracy.

### ✅ 6. Column Optimization
- Dropped irrelevant or unused columns to streamline analysis.

---

## 🛠️ Tools & Technologies

| Tool        | Purpose                       |
|-------------|-------------------------------|
| MySQL       | Data storage and transformation |
| SQL Queries | Data cleaning operations      |
| CSV         | Initial data source format    |

---

---

## 🧠 Learning Outcomes

- Working with real-world messy data
- Applying SQL transformations to improve data quality
- Building a clean database structure for downstream analysis

---


## 📝 License

This repository is intended for academic and learning purposes. Not for commercial reuse.
