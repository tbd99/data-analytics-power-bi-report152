# data-analytics-power-bi-report152
The aim of this project is to create a Power BI report for a a medium-sized international retailer to transofrm sales data into actionable insights using a robust data model to construct a multi page report. The report will present a high-level business summary for C-suite executives as well as giving insights into the highest value customers, segmented by sales region. The report will provide a detailed analysis of top-performing products, categorised by type against sales targets, as well as a map visual spotlighting the performance metrics of retail outlets across different territories.

## Project description

### Part 1, loading and transforming data in Power BI
The Orders table was loaded from an Azure SQL database and data was transformed to filter null/missing values and columns were edited in Power Query Editor. Order Date and Shipping Date columns were each split into a date column and a time column. Sensitive data was removed to ensure data privacy.

The Products table was loaded from a .csv file. Calculated columns were created from the weight column and DAX expressions utilised to give a column containing all weight values with consistent units.

The Stores table was loaded from Azure Blob Storage and columns were renamed to align with Power BI naming conventions.

The Customers table was loaded with the Folder data connector, the three files were combined and transformed in a single query and loaded into a single table. A Full Name column was created by combining First Name and Last Name columns.

## Installation instructions

## Usage instructions

## File structure

## License information