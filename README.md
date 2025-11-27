# Data_Migration_PostgreSQL_to_Redshift
Data migration from local database using PostgreSQL to cloud data warehouse AWS Redshift.
![project flow](screen/project_flow.png)

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
* Faster Time to Insight: Analysts and data consumers can get results from complex queries in seconds instead of minutes or hours, accelerating the entire decision-making cycle.
* Improved Operational Performance: Moving analytical workloads off PostgreSQL eliminates resource contention, ensuring the primary transactional database remains fast and responsive for business-critical applications (e.g., customer checkouts, inventory updates).
* Cost Optimization: Redshift's elasticity and compression can often provide a better price/performance ratio for analytics compared to over-provisioning a traditional relational database just to handle large reports.

# Key Leverage Points (Why Redshift is Better for Analytics)
* Architecture - Faster query execution for analytical queries that only read a subset of columns.
* Storage - Reduces storage costs and improves query I/O performance.
* Scalability - Handles exponential data growth and workload spikes automatically or easily.
* Ecosystem - Facilitates a modern, end-to-end data lakehouse 

# *Project Plan*
Step-by-Step Data Migration (Manual Method):
1. Exporting data from PostgreSQL to CSV files
   ```bash
   customer=# \copy transactions to '/home/mulyo/Learning/redshift/psql_transaction.csv' with (FORMAT CSV, HEADER);

   ❯ la psql_transaction.csv
    Permissions Size User  Date Modified Name
    .rw-rw-r--   36M mulyo 26 Nov 07:44   psql_transaction.csv
   ```
2. Uploading those files to an Amazon S3 bucket
   * Create S3 Bucket: Console Home > Amazon S3 > Create Bucket (exp: customer-trans-bucket) > Create folder (exp: landing)
   * Upload CSV file into S3 Bucket: Console Home > Amazon S3 > customer-trans-bucket > landing/ > upload (exp: "psql_transaction.csv") 
5. Loading the data into Redshift
   * Create cluster: Console Home > Amazon Redshift > Provisioned clusters dashboard > Create cluster (exp: redshift-cluster-1)
   * Completing cluster configuration:
     * Cluster identifier (exp: redshift-cluster-2)
     * Node type (exp: ra3.large)
     * AZ configuration (exp: Single-AZ)
     * Number of node (exp: 2)
   * Database configuration:
     * Admin user name (exp: aswuser)
     * Admin password > Manually add the admin password
     * Choose key type > AWS onwed key
   * Associate IAM role > Create IAM role or find from existing
   * Create user
   * Amazon Redshift > Redshift query editor v2
     ```sql
     COPY dev.landing.transaction FROM 's3://customer-trans-bucket/landing/psql_transaction.csv' IAM_ROLE 'arn:aws:iam::************:role/service-role/AmazonRedshift-CommandsAccessRole-****************' FORMAT AS CSV DELIMITER ',' QUOTE '"' IGNOREHEADER 1 REGION AS 'ap-southeast-3';
     
     SELECT * FROM dev.landing.transaction LIMIT 10;
     ```
# *Asumption*
1. Local database PostgreSQL with data ready to be migrated & admin authorization
2. AWS account with IAM with permissions policies:
   * AmazonS3FullAccess
   * AmazonRedshiftReadOnlyAccess 
