# 📊 Data Analyst Job Market SQL Project

Explore the real-world data analyst job market using SQL!
This project analyzes top-paying jobs, in-demand skills, salary trends, and optimal skills for career growth — all through SQL queries written and executed by me.

---

## 🚀 **Project Overview**

The goal of this project is to understand:

1. **Top-paying data analyst jobs**
2. **Skills required for high-salary roles**
3. **Most in-demand skills for data analysts**
4. **Skills associated with higher salaries**
5. **Optimal skills to learn** for maximizing job market value

This analysis is based on 2023 job postings and covers thousands of real listings.

---

## 🛠️ **Tools & Technologies**

* **SQL** – Used to query, filter, and analyze job postings
* **PostgreSQL** – Database used for the raw job data
* **Visual Studio Code** – For writing and executing SQL
* **Git & GitHub** – Version control and documentation

---

# 📈 The Analysis

Each section below includes the **SQL queries I wrote** and the insights gained from the results.

---

# 🔍 **1. Top-Paying Data Analyst Jobs**

### **SQL Query**

```sql
SELECT	
	job_id,
	job_title,
	job_location,
	job_schedule_type,
	salary_year_avg,
	job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

### **Insights**

* Top salaries range from **$184K to $650K**
* Major companies like **SmartAsset, Meta, AT&T** appear frequently
* Heavy variation in job titles (Analyst → Director) shows diversity in responsibilities

---

# 🧠 **2. Skills Needed for Top-Paying Jobs**

### **SQL Query**

```sql
WITH top_paying_jobs AS (
    SELECT	
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        job_location = 'Anywhere' AND 
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
```

### **Insights**

Most frequent skills among the top 10 high-paying jobs:

| Skill   | Count |
| ------- | ----- |
| SQL     | 8     |
| Python  | 7     |
| Tableau | 6     |

Other skills include R, Pandas, Excel, Snowflake.

🔥 **Conclusion:**
Top-paying roles require strong technical skills — particularly **SQL + Python + Tableau**.

---

# 📊 **3. Most In-Demand Skills for Data Analysts**

### **SQL Query**

```sql
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' 
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

### **Insights**

| Skills   | Demand Count |
| -------- | ------------ |
| SQL      | 7,291        |
| Excel    | 4,611        |
| Python   | 4,330        |
| Tableau  | 3,745        |
| Power BI | 2,609        |

✔ **SQL and Excel dominate**
✔ Python + Visualization tools are also essential

These skills form the **core toolkit** for most data analyst roles.

---

# 💸 **4. Skills Associated With Higher Salaries**

### **SQL Query**

```sql
SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```

### **Top-Paying Skills**

| Skills        | Avg Salary |
| ------------- | ---------- |
| PySpark       | $208,172   |
| Bitbucket     | $189,155   |
| Couchbase     | $160,515   |
| Watson        | $160,515   |
| DataRobot     | $155,486   |
| GitLab        | $154,500   |
| Swift         | $153,750   |
| Jupyter       | $152,777   |
| Pandas        | $151,821   |
| Elasticsearch | $145,000   |

### **Insights**

High-paying skills fall into categories like:

* **Big data tools** (PySpark, Hadoop, Elasticsearch)
* **Machine learning platforms** (DataRobot, Jupyter)
* **Cloud & DevOps tools** (GitLab, Kubernetes, Snowflake)

➡ **These specialized skills command higher salaries.**

---

# 🎯 **5. Most Optimal Skills to Learn (High Demand + High Salary)**

### **SQL Query**

```sql
SELECT 
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True 
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;
```

### **Top Optimal Skills**

| Skill      | Demand | Avg Salary |
| ---------- | ------ | ---------- |
| Go         | 27     | $115,320   |
| Confluence | 11     | $114,210   |
| Hadoop     | 22     | $113,193   |
| Snowflake  | 37     | $112,948   |
| Azure      | 34     | $111,225   |
| BigQuery   | 13     | $109,654   |
| AWS        | 32     | $108,317   |
| Java       | 17     | $106,906   |
| SSIS       | 12     | $106,683   |
| Jira       | 20     | $104,918   |

### **Insights**

These skills offer the **best combination of demand and salary**:

* **Cloud platforms:** AWS, Azure, Snowflake
* **Big data tools:** Hadoop, BigQuery
* **Programming:** Go, Java
* **BI & workflow tools:** SSIS, Jira

---

# 🧩 What I Learned

Through this project, I strengthened:

### ✔ Advanced SQL Techniques

* CTEs
* Multi-table joins
* Subqueries
* Aggregations

### ✔ Real-World Data Analysis Skills

* Identifying trends
* Translating business questions into SQL
* Presenting insights clearly

### ✔ Job Market Knowledge

* Understanding what skills matter most
* Recognizing industry salary trends

---

# 🏁 Conclusion

### **Key Insights from the Project**

1. **SQL is the most essential skill** for data analysts — both in demand and salary.
2. Top-paying roles require strong skills in **SQL, Python, Tableau**.
3. Specialized tools like **PySpark, Snowflake, Hadoop** significantly increase earning potential.
4. Cloud and big data technologies are now critical in analytics.
5. The best skills to learn combine **high demand + high salary**.

---

# 📚 Project Files

📂 **SQL Scripts:** `/project_sql/`
📊 **Visualizations:** `/assets/`
📄 **README:** This file

---

If you'd like, I can also:

✅ Add icons and badges
✅ Make a shorter “portfolio-focused” version
✅ Add installation/setup instructions
✅ Convert this into a portfolio website section

Just tell me!
