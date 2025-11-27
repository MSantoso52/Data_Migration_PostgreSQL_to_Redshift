# Data_Migration_PostgreSQL_to_Redshift
Data migration from local database using PostgreSQL to cloud data warehouse AWS Redshift.

# *Project Overview*
Data migration from local database using PostgreSQL to cloud data warehouse AWS Redshift.Data migration from PostgreSQL (typically an OLTP-Online Transactional Processing-database) to Amazon Redshift (a columnar OLAP-Online Analytical Processing-data warehouse) is common for leveraging high-performance analytics. This project we will use easiest way, manual process using S3 Bucket and the Redshift COPY command. 

# *Problem to be Solved*
* The core problem is the limitations of a relational OLTP database (PostgreSQL) when facing massive-scale analytical queries.
Slow Analytical Queries: PostgreSQL's row-oriented storage is optimized for quick row insertion and updates (transactions). When running complex analytical queries (e.g., joins, aggregations) across billions of rows, it becomes I/O bound and extremely slow.
* Concurrency Issues: Running heavy analytics on the same database used for live transactions (OLTP) leads to resource contention, slowing down both the application's transaction speed and the reporting/BI queries.
* Scaling Difficulty: Scaling a row-oriented database like PostgreSQL for analytical workloads typically requires costly vertical scaling (bigger server) or complex manual sharding, which is difficult to manage.

# *Business Impact & Leverage*
Migrating to Amazon Redshift directly translates to better business intelligence and decision-making capabilities.

# Business Impact
●	Faster Time to Insight: Analysts and data consumers can get results from complex queries in seconds instead of minutes or hours, accelerating the entire decision-making cycle.
* Improved Operational Performance: Moving analytical workloads off PostgreSQL eliminates resource contention, ensuring the primary transactional database remains fast and responsive for business-critical applications (e.g., customer checkouts, inventory updates).
* Cost Optimization: Redshift's elasticity and compression can often provide a better price/performance ratio for analytics compared to over-provisioning a traditional relational database just to handle large reports.
