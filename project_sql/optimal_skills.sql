WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM 
        job_postings_fact
    INNER JOIN 
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN 
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_dim.skill_id, skills_dim.skills
), average_salary AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        ROUND(AVG(salary_year_avg),2) AS avg_salary
    FROM 
        job_postings_fact
    INNER JOIN 
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN 
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY 
        skills_dim.skill_id, skills_dim.skills
)
SELECT 
    sd.skill_id,
    sd.skills,
    sd.demand_count,
    asq.avg_salary
FROM
    skills_demand sd
INNER JOIN 
    average_salary asq ON sd.skill_id = asq.skill_id

ORDER BY 
    demand_count DESC,
    avg_salary DESC
LIMIT 30


/*
📊 Key Observations
1. High Demand Skills
SQL → 398 postings, avg salary ≈ $97k

Excel → 256 postings, avg salary ≈ $87k

Python → 236 postings, avg salary ≈ $101k

Tableau → 230 postings, avg salary ≈ $99k

👉 These are the core skills most frequently requested for Data Analyst roles. SQL dominates demand, but Python offers higher pay.

2. High Salary Skills (Niche but lucrative)
Go → $115k, demand 27

Hadoop → $113k, demand 22

Snowflake → $113k, demand 37

Azure → $111k, demand 34

BigQuery → $110k, demand 13

👉 These are specialized skills with fewer postings but premium salaries. Great for differentiation.

3. Balanced Skills (Strong demand + strong salary)
Python → 236 demand, $101k salary

Tableau → 230 demand, $99k salary

R → 148 demand, $100k salary

Power BI → 110 demand, $97k salary

👉 These strike a sweet spot: widely requested and well-paid.

🏆 Optimal Skill Insight
If you want maximum job opportunities → Learn SQL first.

If you want best balance of demand + salary → Focus on Python (strong demand, high pay).

If you want niche premium salaries → Add Snowflake, Hadoop, Azure, or Go to stand out.

🎯 Recommendation Path
Foundation: SQL + Excel (baseline for almost every analyst role).

Growth: Python + Tableau/Power BI (data analysis + visualization).

Differentiation: Cloud/data engineering tools (Snowflake, Hadoop, Azure, BigQuery, Go).

This way,
*/

/*
[
  {
    "skill_id": 0,
    "skills": "sql",
    "demand_count": "398",
    "avg_salary": "97237.16"
  },
  {
    "skill_id": 181,
    "skills": "excel",
    "demand_count": "256",
    "avg_salary": "87288.21"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "236",
    "avg_salary": "101397.22"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "demand_count": "230",
    "avg_salary": "99287.65"
  },
  {
    "skill_id": 5,
    "skills": "r",
    "demand_count": "148",
    "avg_salary": "100498.77"
  },
  {
    "skill_id": 183,
    "skills": "power bi",
    "demand_count": "110",
    "avg_salary": "97431.30"
  },
  {
    "skill_id": 7,
    "skills": "sas",
    "demand_count": "63",
    "avg_salary": "98902.37"
  },
  {
    "skill_id": 186,
    "skills": "sas",
    "demand_count": "63",
    "avg_salary": "98902.37"
  },
  {
    "skill_id": 196,
    "skills": "powerpoint",
    "demand_count": "58",
    "avg_salary": "88701.09"
  },
  {
    "skill_id": 185,
    "skills": "looker",
    "demand_count": "49",
    "avg_salary": "103795.30"
  },
  {
    "skill_id": 188,
    "skills": "word",
    "demand_count": "48",
    "avg_salary": "82576.04"
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "demand_count": "37",
    "avg_salary": "112947.97"
  },
  {
    "skill_id": 79,
    "skills": "oracle",
    "demand_count": "37",
    "avg_salary": "104533.70"
  },
  {
    "skill_id": 61,
    "skills": "sql server",
    "demand_count": "35",
    "avg_salary": "97785.73"
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "demand_count": "34",
    "avg_salary": "111225.10"
  },
  {
    "skill_id": 76,
    "skills": "aws",
    "demand_count": "32",
    "avg_salary": "108317.30"
  },
  {
    "skill_id": 192,
    "skills": "sheets",
    "demand_count": "32",
    "avg_salary": "86087.79"
  },
  {
    "skill_id": 215,
    "skills": "flow",
    "demand_count": "28",
    "avg_salary": "97200.00"
  },
  {
    "skill_id": 8,
    "skills": "go",
    "demand_count": "27",
    "avg_salary": "115319.89"
  },
  {
    "skill_id": 199,
    "skills": "spss",
    "demand_count": "24",
    "avg_salary": "92169.68"
  },
  {
    "skill_id": 22,
    "skills": "vba",
    "demand_count": "24",
    "avg_salary": "88783.29"
  },
  {
    "skill_id": 97,
    "skills": "hadoop",
    "demand_count": "22",
    "avg_salary": "113192.57"
  },
  {
    "skill_id": 233,
    "skills": "jira",
    "demand_count": "20",
    "avg_salary": "104917.90"
  },
  {
    "skill_id": 9,
    "skills": "javascript",
    "demand_count": "20",
    "avg_salary": "97587.00"
  },
  {
    "skill_id": 195,
    "skills": "sharepoint",
    "demand_count": "18",
    "avg_salary": "81633.58"
  },
  {
    "skill_id": 4,
    "skills": "java",
    "demand_count": "17",
    "avg_salary": "106906.44"
  },
  {
    "skill_id": 201,
    "skills": "alteryx",
    "demand_count": "17",
    "avg_salary": "94144.53"
  },
  {
    "skill_id": 78,
    "skills": "redshift",
    "demand_count": "16",
    "avg_salary": "99936.44"
  },
  {
    "skill_id": 197,
    "skills": "ssrs",
    "demand_count": "14",
    "avg_salary": "99171.43"
  },
  {
    "skill_id": 77,
    "skills": "bigquery",
    "demand_count": "13",
    "avg_salary": "109653.85"
  }
]
*/