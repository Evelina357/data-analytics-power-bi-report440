# Data Analytics Power BI Report

**Scenario and task given:**
<br>
_You have recently been approached by a medium-sized international retailer who is keen on elevating their business intelligence practices. With operations spanning across different regions, they've accumulated large amounts of sales from disparate sources over the years._

_Recognizing the value of this data, they aim to transform it into actionable insights for better decision-making. Your goal is to use Microsoft Power BI to design a comprehensive Quarterly report. This will involve extracting and transforming data from various origins, designing a robust data model rooted in a star-based schema, and then constructing a multi-page report._

_The report will present a high-level business summary tailored for C-suite executives, and also give insights into their highest value customers segmented by sales region, provide a detailed analysis of top-performing products categorised by type against their sales targets, and a visually appealing map visual that spotlights the performance metrics of their retail outlets across different territories._
<br>
<br>
The work in the project is described through **10 Milestones**.
<br>
## Milestone 1: Set up the Environment

A new GitHub repository was created where the the Power Bi project and any other associated documents will be stored. Then the connection between GitHub and local repository was establish for easy edit and transfer of files. 

## Milestone 2: Import the Data into Power BI

The data from the retailer was divided into four tables: **Orders**, **Products**, **Stores** and **Customers**.
<br>

### 2.1: Load and Transform Orders Table

The **Orders** table contains information about each order including the order and shipping dates, the customer, store and product IDs for associating with dimension tables, and the amount of each product ordered. Each order in this table consists of an order of a single product type, so there is only one product code per order.
<br>
<br>
The *Orders* table was imported by connecting with Azure SQL Database (using the given credentials such as server name, database name, username and password) and then using the *Import* option in Power BI. 
<br>
Then the table was edited via *Power Query Editor*:
 - [Card Number] column was deleted for data privacy reasons.
 - Using the *Split Column* feature, columns [Order Date] and [Shipping Date], containing both date and time, were split into two separate columns each in order to contain date and time values separately. The new columns are called [Order Date], [Order Time], [Shipping Date], [Shipping Time]. 
 - Via *Column Quality* view option it was observed that [Order Date] column has a small amount missing/null values. As a result, the rows containing those values were removed to maintain data integrity
 - All columns' names were checked and renamed (if needed) to align with Power BI naming conventions. This ensures the clarity and consistency of the report. </ul>

### 2.2: Import and Transform Products Dimension Table

The **Products** table contains information about each product sold by the company, including the product code, name, category, cost price, sale price, and weight.
<br>
<br>
The *Products* table was downloaded from the given online link as a .csv file and then imported into Power BI. 
