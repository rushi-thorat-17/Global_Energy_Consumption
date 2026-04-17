# 🌍 Global Energy Consumption & Emission Analysis Using SQL  
A comprehensive end-to-end SQL project analyzing global **energy consumption, production, emissions, GDP**, and **population** trends across multiple countries.  
This project highlights how nations use energy, how economic factors influence demand, and how sustainability patterns evolve globally.

---

## 🚀 Project Highlights  
- 📊 Built a **fully relational SQL database** with 6 interconnected tables  
- 🔍 Performed **complex analytical queries** with joins & window functions  
- 🌱 Identified **major pollution sources** & global emission contributors  
- 📈 Analyzed **GDP–Energy–Population relationships**  
- 🌎 Compared countries on **per-capita, production, and efficiency metrics**  
- 🔥 Delivered **30+ actionable insights** through SQL analysis  

---
## 🛠️ Tech Stack  
| Component | Details |
|----------|---------|
| Language | SQL (MySQL / MariaDB) |
| Concepts Used | Joins, Window Functions, Aggregates, Trend Analysis, Per-Capita Metrics |
| Tools | MySQL Workbench / VS Code |
| Domain | Energy, Economics, Sustainability |

---

## 🗂️ Database Architecture  
The project uses a multi-table schema ensuring referential integrity:

- **country_3** → Country master  
- **emission_3** → Emissions by energy type 
- **production_3** → Energy production  
- **consum_3** → Energy consumption  
- **population_3** → Population data  
- **gdp_3** → GDP data  

Each dataset is connected using **foreign key relationships** for accurate trend analysis.

---

## 🎯 Key Questions Answered  
### 🔹 Energy Insights  
- Which energy types produce maximum emissions?  
- What are the yearly global emission patterns?  
- Which countries have reduced per-capita emissions?

### 🔹 Economic Insights  
- Top 5 GDP countries in the latest year  
- Emission-to-GDP efficiency  
- Production vs consumption imbalance  

### 🔹 Demographic Insights  
- Population impact on emissions  
- Production per capita  
- Global share (%) of emissions by country  

---

## 📊 Sample SQL Queries  

### ▶ Top 5 Countries by GDP
```sql
SELECT country, value AS gdp
FROM gdp_3
WHERE year = (SELECT MAX(year) FROM gdp_3)
ORDER BY value DESC
LIMIT 5;
