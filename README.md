# data-analytics-power-bi-report152
## Project overview
The aim of this project is to create a Power BI report for a a medium-sized international retailer to transofrm sales data into actionable insights using a robust data model to construct a multi page report. The report will present a high-level business summary for C-suite executives as well as giving insights into the highest value customers, segmented by sales region. The report will provide a detailed analysis of top-performing products, categorised by type against sales targets, as well as a map visual spotlighting the performance metrics of retail outlets across different territories. Supplementary SQL metrics will also be created in order to provide data insights to clients who do not have access to Power BI. 

# Table of Contents
1. [Detailed project description](#detailed-project-description)
    - [Part 1, loading and transforming data in Power BI (milestone 2)](#part-1-loading-and-transforming-data-in-power-bi-milestone-2)
    - [Part 2, creating a data model (milestone 3)](#part-2-creating-a-data-model-milestone-3)
       - [Date table](#date-table)
       - [Star schema](#star-schema)
       - [Measures table](#measures-table)
       - [Hierarchies](#hierarchies)
    - [Part 3, building the Customer Detail report page (milestone 5)](#part-3-building-the-customer-detail-report-page-milestone-5)
       - [Customers headline card visuals](#customers-headline-card-visuals)
       - [Customers donut chart](#customers-donut-chart)
       - [Customers column chart](#customers-column-chart)
       - [Customers line chart](#customers-line-chart)
       - [Customers table](#customers-table)
       - [Top customers card visuals](#top-customers-card-visuals)
       - [Customers slicer](#customers-slicer)
    - [Part 4, building the Executive Summary report page (milestone 6)](#part-4-building-the-executive-summary-report-page-milestone-6)
       - [Executive summary headline card visuals](#executive-summary-headline-card-visuals)
       - [Executive summary line chart](#executive-summary-line-chart)
       - [Executive summary donut charts](#executive-summary-donut-charts)
       - [Executive summary clustered bar chart](#executive-summary-clustered-bar-chart)
       - [Executive summary table](#executive-summary-table)
       - [Executive summary KPIs](#executive-summary-kpis)
       - [Executive summary slicer](#executive-summary-slicer)
    - [Part 5, building the Product Detail report page (milestone 7)](#part-5-building-the-product-detail-report-page-milestone-7)   
       - [Product detail gauge visuals](#product-detail-gauge-visuals)
       - [Product detail area chart](#product-detail-area-chart)
       - [Product detail table](#product-detail-table)
       - [Product detail scatter graph](#product-detail-scatter-graph)
       - [Product detail slicer](#product-detail-slicer)
    - [Part 6, building the Stores Map page (milestone 8)](#part-6-building-the-stores-map-page-milestone-8)
       - [Stores map visual](#stores-map-visual)
       - [Stores map drillthrough](#stores-map-drillthrough)
       - [Stores map tooltip](#stores-map-tooltip)
    - [Part 7, cross-filtering and navigation (milestone 9)](#part-7-cross-filtering-and-navigation-milestone-9)
       - [Editing interactions](#editing-interactions)
       - [Completing the navigation bar](#completing-the-navigation-bar)
    - [Part 8, Creating metrics in SQL (milestone 10)](#part-8-creating-metrics-in-sql-milestone-10)
       - [How many staff are there in all of the UK stores?](#1-how-many-staff-are-there-in-all-of-the-uk-stores)
       - [Which month in 2022 has had the highest revenue?](#2-which-month-in-2022-has-had-the-highest-revenue)
       - [Which German store type had the highest revenue for 2022?](#3-which-german-store-type-had-the-highest-revenue-for-2022)
       - [Create a view where the rows are store types and columns are total sales and count of orders](#4-create-a-view-where-the-rows-are-the-store-types-and-the-columns-are-the-total-sales-percentage-of-total-sales-and-the-count-of-orders)
       - [Which product category generated the most profit for the "Wiltshire, UK" region in 2021?](#5-which-product-category-generated-the-most-profit-for-the-wiltshire-uk-region-in-2021)
2. [Installation instructions](#installation-instructions)
3. [Usage instructions](#usage-instructions)
4. [File structure](#file-structure)

# Detailed project description

## Part 1, loading and transforming data in Power BI (milestone 2)
The Orders table was loaded from an Azure SQL database and data was transformed to filter null/missing values. Columns were edited in Power Query Editor. Order Date and Shipping Date columns were each split into a date column and a time column. Sensitive data was removed to ensure data privacy.

The Products table was loaded from a .csv file. The Remove Duplicates function was used on the product_code column to ensure each product code is unique. Data in the weight column was transformed using Power Query Editor. The Column From Examples feature was used to generate two new columns from the weight column, one for the weight values and another for the units. For the newly created units column, blank entries were replaced with kg. For the values column, data type was converted to a decimal number. A calculated column was created from the weight column using DAX expressions to create a column containing all weight values with consistent units (kg). If the unit was not kg, the corresponding value in the values column is divided by 1000 to convert to kg. 

~~~
Weight Kg = IF(('Products'[Weight unit] = "kg"), 'Products'[Weight value], ('Products'[Weight value]/1000))
~~~

The Stores table was loaded from Azure Blob Storage and columns were renamed to align with Power BI naming conventions.

The Customers table was loaded with the Folder data connector, the three files were combined and transformed in a single query and loaded into a single table. A Full Name column was created by combining First Name and Last Name columns and unused columns such as index columns were deleted. 

## Part 2, creating a data model (milestone 3)
### Date table
A continous date table was created to cover the time period of the data. Additional columns were added with DAX formulas including: day of week, month number, month name, quarter etc.

### Star schema
A star schema was created by creating relationships from the Orders table to the other tables in the model. All relationships from the Orders table outwards to the other tables are many-to-one, with a single filter direction from the Order table (many) to the other tables (one).

### Measures table
A separate measures table was created for ease of navigation and good data management. Useful measures were added including: Total Orders, Total Revenue, Total Profit, Total Customers, Total Quantity, and Profit and Revenue YTD (Year To Date).

### Hierarchies
A date hierarchy was created in the Dates table to enable drilling down and granular analysis.

A geography hierarchy was created in the Stores table to enable filtering by region, country, and province/state. Geographical data was assigned the correct data category (Continent/Country/State or Province) to facilitate analysis. 

## Part 3, building the Customer Detail report page (milestone 5)
### Customers headline card visuals
Headline card visuals were created to show the total customers and revenue per customers, these were created using measures constructed using DAX formulae.

### Customers donut chart
A donut chart was created to show the total customers per country, the 'Country' column in the Customers table was used to filter the Total Customers measure to create this chart.

### Customers column chart
A column chart was created showing the number of customers who purchased each product category, the 'Category' column in the Products table was used to filter the Total Customers measure to create this chart.

### Customers line chart
A line chart was created to show Total Customers over time. The date hierarchy created in milestone 3 was used to define the Y axis, enabling users to drill down from the year level to the month level. A trend line was added, as well as a forecast line over the next 10 periods with a 95% confidence interval.

### Customers table
A table was created to display the top 20 customers based on revenue. The table shows the full name, revenue and number of orders for each customer. TopN filtering was used to filter for the top 20 customers by revenue. Conditional formatting was applied to add data bars to the Total Revenue column.

### Top customers card visuals
A set of three card visuals were created to show the top customer by revenue, displaying the customer's full name, number of orders they have made, and the total revenue generated by the customer. DAX formulae were used to generate measures to create these card visuals. 

### Customers slicer
Finally, a date slicer was added to enable users to fitler the report page by year.

## Part 4, building the Executive Summary report page (milestone 6)
### Executive summary headline card visuals
Headline card visuals were created to show the Total Revenue, Total Orders and Total Profit, these were created using measures previously constructed using DAX formulae.

### Executive summary line chart
A line chart was created to show Total Revenue over time. The date hierarchy created in milestone 3 was used to define the Y axis, enabling users to drill down from the year level to the month level. A trend line was added, as well as a forecast line over the next 10 periods with a 95% confidence interval.

### Executive summary donut charts
A donut chart was created to show the total revenue per store country, the 'Country' column in the Stores table was used to filter the Total Revenue measure to create this chart.

A donut chart was created to show the total revenue per store type, the 'Store Type' column in the Stores table was used to filter the Total Revenue measure to create this chart.

### Executive summary clustered bar chart
A clustered bar chart was created showing the number of orders per each product category, the 'Category' column in the Products table was used to filter the Total Orders measure to create this chart.

### Executive summary table
A table was created to display the top 10 products based on revenue. The table shows the Product Description, Category, Total Orders, Total Customers and the Total Revenue generated for each product. TopN filtering was used to filter for the top 10 customers by revenue. Conditional formatting was applied to add data bars to the Total Revenue column.

### Executive summary KPIs
A set of three KPI visuals were created to show Quarterly Revenue, Quarterly Profit, Quarterly Orders and the associated quarterly targets for each of these measures. DAX formulae were used to generate measures to create these card visuals. 

### Executive summary slicer
Finally, a date slicer was added to enable users to fitler the report page by year.

## Part 5, building the Product Detail report page (milestone 7)
### Product detail gauge visuals
Gauge visuals were created to show the current performance of Orders, Revenue and Profit against quarterly targets, these were created using measures constructed using DAX formulae. Maximum gauge value was set to the quarterly target for each measure, and conditional formatting was applied so the callout value would show red if the target it not met, and black if it is. 

### Product detail area chart
An area chart was created to show the performance of different product categories over time. Total Revenue was plotted against Dates[Start of Quarter] with Products[Category] as the legend.

### Product detail table
The top 10 products table was copied from the Executive summary page and formatted. 

### Product detail scatter graph
A scatter graph was created to show the quantity of sales for each product category against profit per item. A calculated column was used to plot Profit per Item. Products[Total Quantity] was plotted against Products[Profit per Item] with Products[Description] as values and Products[Category] as the legend. 

### Product detail slicer
A slicer filter toolbar was created to allow users to control how the data on the page are filtered. Two new vertical list slicers were created to enable the user to filter by Product Category from Products[Category] and Country from Stores[Country]. A slicer toolbar was created with these slicers and a back button, linked to a bookmark with the toolbar hidden to allow users to click back to the main report page. A filter button was created on the main report page, linked to a bookmark with the toolbar open to allows users to navigate to the slicer toolbar from the main report page. 

Measures were created to show the selected value for each slicer. These measures were used to create card visuals to display the categories selected to the user. 

## Part 6, building the Stores Map page (milestone 8)
### Stores map visual
A map visual was created using the previously created geographical hierarchy with the Profit YTD measure as values. A tile style slicer was added with Stores[Country] as the field to allow users to filter by country or show all countries. 

### Stores map drillthrough
A drillthrough page was created to allow users to quickly see an overview of a store's performance. A table was created to show the top 5 products based on total revenue, with columns: Description, Profit YTD, Total Orders, Total Revenue. A column chart showing the Total Orders by product category for the store was created. Gauges were created for Profit YTD against a profit target of 20% year-on-year growth vs. the same period in the previous year. An equivalent gauge was created for Revenue YTD. Measures were calculcated to derive profit and revenue targets. A card visual was created to show the currently selected store. 

### Stores map tooltip 
A tooltip page was created to enable users to quickly see each stores Profit YTD performance against the profit target by hovering over a store on the map. The profit gauge visual created in the previous step was copied to the tooltip page. 

## Part 7, cross-filtering and navigation (milestone 9)

### Editing interactions
In the executive summary report page, interactions were edited to the Product Category bar chart would not filter card visuals or KPIs. The Top 10 Products table was set so that it wold not affect any other visuals.

In the customer detail report page, the Top 20 Customers table was set to not filter any other visuals. The Total customers by Product bar chart was set to not filter the Customers line graph. The Total Customers by Country donut chart was set to have cross-filtering with the Total Customers by Product bar chart. 

In the product detail page, the Orders vs. Profitability graph was set to have no interactions with other visuals.

### Completing the navigation bar 
The navigation bar was completed to enable users to navigate between report pages by clicking on the corresponding icon. 4 buttons were created with custom images to represent each of the 4 report pages. Each button was formatted by formatting the Button Style so that the button would appear a different colour when a user hovers over the button. The Action format option was edited for each button to define each button type as Page Navigation and then link each button to the appropriate page. The buttons were copied across all report pages to enable navigation from any page to another. 

## Part 8, Creating metrics in SQL (milestone 10)
Additional metrics were created in SQL to provide data insights to clients who do not have access to Power BI. 
In this part, data was queried from a Postgres database hosted on Microsoft Azure by connecting to the server in VSCode using the SQLTools extension

A list of table names was printed and saved to a .csv file. Lists of column names for each respecive table were printed and saved to .csv files. 

SQL queries were constructed to answer the following questions:

### 1. How many staff are there in all of the UK stores?

### 2. Which month in 2022 has had the highest revenue?

### 3. Which German store type had the highest revenue for 2022?

### 4. Create a view where the rows are the store types and the columns are the total sales, percentage of total sales and the count of orders

### 5. Which product category generated the most profit for the "Wiltshire, UK" region in 2021?

Details of the SQL queries used to answer these questions can be found in the SQL_metrics subfolder.
## Installation instructions
Power BI access is required to view the Power BI report.
SQL queries were created in VSCode using the SQL tools module to query the Postgres database server hosted on Microsoft Azure. 

## Usage instructions
The report is split into 4 main sections:
- Executive Summary page: provides a high level overview of the data across all categories
- Customer Detail page: provides a more detailed view of the number of customers and the distribution of customers according to country and product category, as well as the top spending customers
- Product Detail page: provides a more detailed view of the performance and profitability of different products according to cateogry and country
- Stores Map page: a map visual displaying the YTD Profit for different regions

Use the navigation bar on the left hand side of each report page to navigate between pages.
Visuals on each report page can be interacted with to reveal data for specific selections. 
The Product Detail page contains a filtering sidebar which can be accessed by ctrl + clicking the filter button to enable users to filter by country and category.
The Stores Map page has a tooltip that enables users to quickly see store profit performance by hovering over different areas.

SQL metrics and files can be found in the SQL_metrics subfolder
## File structure
The Power BI report session and README file are contained in the top level of the project folder. 
The images_and_visualisations folder contains images of working and visualisation from each of the sections of the project. Within this folder work from each milestone of the project (3, 5, 6, 7, 8, 9) are divided into subfolders corresponding to the milestone number. 
- Miilestone 3 is the data modelling portion of the project.
- Milestone 5 is the construction of the customer detail report page.
- Milestone 6 is the construction of the executive summary report page.
- Milestone 7 is the construction of the product detail report page.
- Milestone 8 is the construction of the stores map page.
- Milestone 9 is the finalisation of the entire Power BI report, including cross-filtering and navigation between report pages.
In each of these subfolders various labelled screenshots are incldued to show:
-  Final report pages and filtered pages
-  DAX formulae used to calculcate measures or calculated columns to create visuals
-  Filters applied to various visuals to achieve the desired results 
SQL files and results (Milestone 10) are saved in the SQL_metrics subfolder
