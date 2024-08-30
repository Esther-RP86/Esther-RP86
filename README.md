# Data Analsis_SQL_Healthcare

**An exploratory data analysis (EDA) is performed using MySQL with basic to advanced SQL queries and functions. The dataset is downloaded in csv. file and later imported into MySQL in my local machine.**

This dataset is retrieved from Kaggle : https://www.kaggle.com/datasets/prasad22/healthcare-dataset/data

### **The queries are divided into 5 sections after Data validation and cleaning:**
### Section 1
This section gives an overview of the data, giving a general idea and sense of most patient's age, the year that the dataset is retrieved, and the ratio of male to female patients. With these data aggregation and summarization and basic statistical calculations, we can gain simple insights into the data and answer basic questions

### Section 2 
This section answer questions mostly about age relating to medical conditions 
  - Age categories are created (as view) in this section to showcase a summary count of patient's within each age group. This helps to identify trends and pattern of number of patients with different age groups.
  - Breaking it down further, the next executed queries would give the correlation between age and the number/count of medical condition, this gives a general understanding of the frequencies of admitted patients when age is taken into consideration.
  -  Another analysis showed prevalent medical condition as well as showing age disribution learning towards a certain number for each medical condition

### Section 3
This section give details about the number of insurance provider involved in patient's billing, and highlights patient's preference as well as financial aspect with regards to medical coverage/insured amount, range and limits associated with each insurance providers. 

### Section 4
This section analyse the general length of stay for patients before receiving the final test results. We can identify if there is a relationship between the average length of stay and the test result ('Normal', 'Abnormal', and 'Inconclusive'). Another set of query is executed for hospitals to allocate reminders to patients who receive the 'Abnormal' and 'Inconclusive' test results.

### Section 5
This section evaluates the performance of each hospitals across the year 2019 to 2024 based on the number or admitted patient's case for the urgent, emergency, and elective admission type. A summary of the number of patient's case is created via pivoting the data. This basically provide enough insights to answer questions relevant to healthcare KPIs and metrics in hospitals. Further analysis include comparing the total count of patient's case for each year across various hospitals. 




<!---
Esther-RP86/Esther-RP86 is a ✨ special ✨ repository because its `README.md` (this file) appears on your GitHub profile.
You can click the Preview link to take a look at your changes.
--->
