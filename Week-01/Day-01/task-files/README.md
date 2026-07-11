# Customer Personality Analysis

## Task: Data Cleaning & Preprocessing

**Author:** Lord Davon Mendoza  
**Dataset:** `marketing_campaign.csv` (Customer Personality Analysis)  
**Tools**: Python (Google Colab), Libraries(pandas)
---


## Notebook Structure & Sequencing

The notebook follows this logical flow:

### 1. Setup & Loading
- Import libraries (`pandas`)
- Load the dataset using `pd.read_csv()` with tab separator (`sep='\t'`)
- Preview the first few rows with `df.head()`

### 2. Data Inspection
Ran an inspection on the raw dataset
- `df.info()` — column names, data types, and non-null counts
- `df.describe()` — summary statistics for all numeric columns
- `df.isnull().sum()` — count of missing values per column
- Unique value inspection for all object (categorical) columns
- Full value count breakdown for every column
- `df.duplicated().sum()` — check for exact duplicate rows

### 3. Column Standardization
- All column names are lowercased, spaces replaced with underscores, and prefixes (`mnt`, `num`, `acceptedcmp`) formatted consistently using `.str.replace()` with regex

### 4. Data Type Validation
- `df.dtypes` is reviewed after renaming to confirm types align with expectations before cleaning begins

### 5. Data Cleaning

| Issue | Column | Action |
|---|---|---|
| Non-numeric income values | `income` | Coerced to numeric; NaNs filled with median |
| Outliers (income > 200,000) | `income` | Rows dropped |
| Wrong data type | `dt_customer` | Converted to `datetime` with `%d-%m-%Y` format |
| Inconsistent/invalid categories | `marital_status` | `'Alone'` → `'Single'`; `'YOLO'` and `'Absurd'` rows dropped |
| Unrealistic birth years (< 1930) | `year_birth` | Rows dropped |
| Irrelevant columns | `z_costcontact`, `z_revenue` | Dropped entirely |

---

## Key Decisions

- **Median imputation for income:** Chosen over mean to reduce the influence of outliers.
- **Hard income cap at 200,000:** Extreme values are treated as data entry errors rather than valid high earners.
- **Birth year floor at 1930:** Rows with birth years before 1930 are flagged as unrealistic and removed.
- **Marital status cleanup:** Non-standard labels (`YOLO`, `Absurd`) are dropped; `Alone` is normalized to `Single` for consistency.


## Output

- Standardized column names
- No missing values in key columns
- Correct data types across all columns
- Outliers and invalid entries removed
- Irrelevant columns dropped

