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
The *Products* table was downloaded from the given online link as a .csv file and then imported into Power BI. In the *Data* view, the *Remove Duplicates* function was used on the [Product Code] column to ensure each product code is unique. Finally the column names were altered to align with the Power BI naming conventions. 

### 2.3: Import and Transform the Stores Dimension Table

The **Stores** table contains information about each store, including the store code, store type, country, region, and address.
<br>
<br>
The *Stores* table was imported by connecting with Azure Blob Storage (using the given credentials such as account name, account key and container name) and using the *Import* option in Power BI. Then the column names were altered to align with the Power BI naming conventions. 

### 2.3: Import and Transform the Customers Table

The **Customers** table contains information about each customer, including their full name, date of birth, company they represent, email, address, country and telephone. 
<br>
<br>
The *Customers* table was downloaded from a given online link as a .zip file which then was unzipped within the local machine. Inside the zip file, a folder with three .csv files was located which contains data about three customer groups (customers from United Kingdom, Germany and United States). This data was imported into the Power BI via *Folder* data connector and then by selecting *Combine and Transform* the three .csv files were merged into one query. Once the data from three customer groups was successfully appended the [Full Name] column was created by merging [First Name] and [Last Name] columns together in *Power Query Editor*. Finally, any unnecessary columns were deleted (in this case only [Source.Name] column) and column names were altered to align with the Power BI naming conventions.

## Milestone 3: Create the Data Model

In order to construct a Data Model, first of all, a comprehensive Date table is built to act as a basis for time intelligence in the Data Model. Secondly, the relationships between key tables are established to build a star-based schema with one to many relationships and a single filter direction. Thirdly, a Measures table (with key measures in it) is created to support the analysis, encompassing metrics like total orders, revenue, and quarter-based performance indicators. Finally, Date and Geographical Hierarchies are created to drill down into the data and perform granular analysis within the report. 

### Task 3.1: Create a Date Table

To make use of Power BI's time intelligence functions, a continuous date table was created covering the period from the earliest date in the Orders[Order Date] column (1st of January 2010) to the latest date in the Orders[Shipping Date] column (28th of June 2023). To do that, a DAX formula of **dates = CALENDAR(DATE(2010,1,1), DATE(2023,6,28))** was used.
<br>
<br>
Then using the just created dates[Date] column, additional columns were derived from it with DAX formulas disclosed:

 - [Day of Week] column:&emsp;&emsp;&ensp;&ensp;&ensp;**Day of Week = FORMAT(dates[Date], "dddd")**
 - [Month Name] column: &emsp;&emsp;&emsp;**Month Name = FORMAT(dates[Date], "MMMM")**
 - [Month Number] column: &emsp;&emsp;**Month Number = MONTH(dates[Date])**
 - [Quarter] column: &emsp;&emsp;&emsp;&emsp;&emsp;&ensp;**Quarter = QUARTER(dates[Date])**
 - [Year] column: &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;**Year = YEAR(dates[Date])**
 - [Start of Year] column: &emsp;&emsp;&emsp;&ensp;**Start of Year = STARTOFYEAR(dates[Date])**
 - [Start of Quarter] column: &emsp;&emsp;**Start of Quarter = STARTOFQUARTER(dates[Date])**
 - [Start of Month] column: &emsp;&emsp;&ensp;**Start of Month = STARTOFMONTH(dates[Date])**
 - [Start of Week] column: &emsp;&emsp;&emsp;**Start of Week = dates[Date] - WEEKDAY(dates[Date],2) + 1** </ul>

### Task 3.2: Build the Star Schema Data Model

In this task the following relationships between tables were created via the *Model View* to form a star schema:

 - products[Product Code] to orders[Product Code]
 - stores[Store Code] to orders[Store Code]
 - customers[User UUID] to orders[User ID] (active relationship)
 - dates[Date] to orders[Shipping Date] (inactive relationship)</ul>

All the relationships mentioned above are one-to-many with a single filter direction flowing from the dimension table side to the fact table side. In our case tables *orders* and *customers* are fact tables while tables *products*, *stores* and *dates* are dimension tables. 
<br> See the image below of the completed star schema:
<br>
<br>
![alt text](star_schema.png)

### Task 3.3: Create a Measures Table

Creating a separate table for measures helps us to keep our data model organised and easy to navigate. A measures table called *measures table* was created in the data **Model View* with **Power Query Editor**. 

### Task 3.4: Create Key Measures

See below a list of key measures created in the *measures table* together with the DAX formulas used to create them:

 - Total Orders:&ensp;&emsp;&emsp;**Total Orders = COUNT(orders[Product Code])**
 - Total Revenue: &ensp;&emsp;**Total Revenue = SUMX(orders, orders[Product Quantity] *  RELATED(products[Sale Price]))**
 - Total Profit: &ensp;&ensp;&emsp;&emsp;**Total Profit = SUMX(orders, orders[Product Quantity] * (RELATED(products[Sale Price]) - RELATED(products[Cost Price])))**
 - Total Customers:&ensp;&ensp;**Total Customers = DISTINCTCOUNT(orders[User ID])**
 - Total Quantity:&ensp;&ensp;&emsp;**Total Quantity = SUM(orders[Product Quantity])**
 - Profit YTD: &ensp;&emsp;&emsp;&emsp;**Profit YTD = TOTALYTD([Total Profit], dates[Date])**
 - Revenue YTD:&ensp;&emsp;&emsp;**Revenue YTD = TOTALYTD([Total Revenue], dates[Date])** </ul>

### Task 3.5: Create Date and Geography 

Hierarchies allow us to to drill down into our data and perform granular analysis within our report. In this report two hierarchies will be created: *Date Hierarchy* and *Geography Hierarchy*.
<br>
<br>
In *dates* table a date hierarchy is created using the following levels:
 - Start of Year
 - Start of Quarter
 - Start of Month
 - Start of Week
 - Date </ul>

Before a geography hierarchy can be creates, several adjustments need to be made in *stores* table. Firstly, a new calculated column named [Country] is created based on the stores[Country Code] column (via **Add Column from Examples** method). It contains country code and a full country name (for example, GB: United Kingdom or US: United States). Secondly, another calculated column named [Geography] is created based on stores[Country Region] and stores[Country] (created by duplicating stores[Country Region] and stores[Country] columns and then merging them together (columns separated by comma and space)). The values in stores[Geography] column would be in the format of "Suffolk, GB: United Kingdom" or "Berlin, DE: Germany". The column can prove to be useful as it can make the mapping more accurate. Finally, the correct data category is assigned to [World Region], [Country] and [Country Region] columns. [World Region] is assigned to category *Continent*, [Country] to *Country* and [Country Region] to *State or Province*. With all these changes, now we can create a geography hierarchy.
<br>
<br>
In *stores* table a geography hierarchy is created using the following levels:
 - World Region
 - Country
 - Country Region </ul>
