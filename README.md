SQL - Order and Shipping Analytics for Performance Optimization

Project Overview
This project involves analyzing orders and shipping data from two databases—commodity and supply—to extract valuable business insights. The project addresses various business challenges, such as transaction pattern identification, fraud detection, shipping performance evaluation, and order cancellation analysis.

Problem Statements Addressed:
1. Order Count by Transaction Type: Retrieve the number of orders by transaction type, excluding orders from specific cities and suspected fraud cases.
2. Order Count by Shipping Mode and Department: Analyze order distribution by shipping mode and department, focusing on departments with at least 40 closed/completed orders.
3. Order Shipment Compliance: Categorize shipments based on actual vs. scheduled shipping days to identify delayed orders by shipping mode.
4. Order Cancellation Rate by State: Rank states based on the cancellation percentage of orders (Cancelled or Suspected Fraud).

Repository Structure:
- Databases: Contains the dataset files for the commodity and supply databases, which are used to run the SQL queries.
- SQL Queries: This folder contains all the SQL queries for solving each of the problem statements mentioned above. Each query is well-documented and optimized for performance.
- PPT (Presentation): The PowerPoint file provides a detailed explanation of the problem statements, business context, and insights derived from the analysis. It offers a visual overview of key findings and their business impact.

Databases Used:
- Commodity Database: Product details, transaction types, and order statuses.
- Supply Database: Shipping mode details, scheduled vs. real shipping days, and departmental performance.

Key Technologies:
1. SQL: Querying and data extraction.
2. MySQL Workbench: For database management.
3. PowerPoint: For presenting business insights.


How to Install and Run the Project
To run the SQL queries and explore the databases used in this project, follow the steps below:

1. Install MySQL Workbench:
- The project uses MySQL Workbench for running SQL queries and managing databases. You can download and install it from the official MySQL website:
MySQL Workbench Download

2. Set Up the Databases:
- After installing MySQL Workbench, import the provided commodity and supply database files from the repository into your MySQL environment.

3. Running SQL Queries:
- Open MySQL Workbench and connect to your local server.
- Open the SQL scripts provided in the SQL Queries folder directly in MySQL Workbench.
- Execute the queries to analyze the data and address the problem statements.

Key Insights:
This project helps identify critical areas for business improvement, such as reducing shipping delays, preventing fraud, and optimizing department performance. The analysis provides actionable insights that can drive better decision-making.
