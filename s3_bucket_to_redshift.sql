COPY dev.landing.transaction FROM 's3://customer-trans-bucket/landing/psql_transaction.csv' IAM_ROLE 'arn:aws:iam::021891587479:role/service-role/AmazonRedshift-CommandsAccessRole-20251126T105551' FORMAT AS CSV DELIMITER ',' QUOTE '"' IGNOREHEADER 1 REGION AS 'ap-southeast-3';

SELECT * FROM dev.landing.transaction LIMIT 10;
