# data-analytics-power-bi-report152
The aim of this project is to create a Power BI report for a a medium-sized international retailer to transofrm sales data into actionable insights using a robust data model to construct a multi page report. The report will present a high-level business summary for C-suite executives as well as giving insights into the highest value customers, segmented by sales region. The report will provide a detailed analysis of top-performing products, categorised by type against sales targets, as well as a map visual spotlighting the performance metrics of retail outlets across different territories.

## Project description

### Part 1, loading and transforming data in Power BI (milestone 2)
The Orders table was loaded from an Azure SQL database and data was transformed to filter null/missing values and columns were edited in Power Query Editor. Order Date and Shipping Date columns were each split into a date column and a time column. Sensitive data was removed to ensure data privacy.

The Products table was loaded from a .csv file. Calculated columns were created from the weight column and DAX expressions utilised to give a column containing all weight values with consistent units.

The Stores table was loaded from Azure Blob Storage and columns were renamed to align with Power BI naming conventions.

The Customers table was loaded with the Folder data connector, the three files were combined and transformed in a single query and loaded into a single table. A Full Name column was created by combining First Name and Last Name columns.

### Part 2, creating a data model (milestone 3)
A continous date table was created to cover the time period of the data. Additional columns were added with DAX formulas including: day of week, month number, month name, quarter etc.

A star schema was created by creating relationships from the Orders table to the other tables in the model. All relationships from the Orders table outwards to the other tables are many-to-one, with a single filter direction from the Order table (many) to the other tables (one).

A separate measures table was created for ease of navigation and good data management. Useful measures were added including: Total Orders, Total Revenue, Total Profit, Total Customers, Total Quantity, and Profit and Revenue YTD (Year To Date).

A date hierarchy was created in the Dates table to enable drilling down and granular analysis.

A geography hierarchy was created in the Stores table to enable filtering by region, country, and province/state. Geographical data was assigned the correct data category (Continent/Country/State or Province) to facilitate analysis. 

### Part 3, building the Customer Detail report page (milestone 5)
Headline card visuals were created to show the total customers and revenue per customers, these were created using measures constructed using DAX formulae.

A donut chart was created to show the total customers per country, the 'Country' column in the Customers table was used to filter the Total Customers measure to create this chart.

A column chart was created showing the number of customers who purchased each product category, the 'Category' column in the Products table was used to filter the Total Customers measure to create this chart.

A line chart was created to show Total Customers over time. The date hierarchy created in milestone 3 was used to define the Y axis, enabling users to drill down from the year level to the month level. A trend line was added, as well as a forecast line over the next 10 periods with a 95% confidence interval.

A table was created to display the top 20 customers based on revenue. The table shows the full name, revenue and number of orders for each customer. TopN filtering was used to filter for the top 20 customers by revenue. Conditional formatting was applied to add data bars to the Total Revenue column.

A set of three card visuals were created to show the top customer by revenue, displaying the customer's full name, number of orders they have made, and the total revenue generated by the customer. DAX formulae were used to generate measures to create these card visuals. 

Finally, a date slicer was added to enable users to fitler the report page by year.

### Part 4, building the Executive Summary report page (milestone 6)
Headline card visuals were created to show the Total Revenue, Total Orders and Total Profit, these were created using measures previously constructed using DAX formulae.

A line chart was created to show Total Revenue over time. The date hierarchy created in milestone 3 was used to define the Y axis, enabling users to drill down from the year level to the month level. A trend line was added, as well as a forecast line over the next 10 periods with a 95% confidence interval.

A donut chart was created to show the total revenue per store country, the 'Country' column in the Stores table was used to filter the Total Revenue measure to create this chart.

A donut chart was created to show the total revenue per store type, the 'Store Type' column in the Stores table was used to filter the Total Revenue measure to create this chart.

A clustered bar chart was created showing the number of orders per each product category, the 'Category' column in the Products table was used to filter the Total Orders measure to create this chart.

A table was created to display the top 10 products based on revenue. The table shows the Product Description, Category, Total Orders, Total Customers and the Total Revenue generated for each product. TopN filtering was used to filter for the top 10 customers by revenue. Conditional formatting was applied to add data bars to the Total Revenue column.

A set of three KPI visuals were created to show Quarterly Revenue, Quarterly Profit, Quarterly Orders and the associated quarterly targets for each of these measures. DAX formulae were used to generate measures to create these card visuals. 

Finally, a date slicer was added to enable users to fitler the report page by year.

## Part 5, building the Product Detail report page (milestone 7)
Gauge visuals were created to show the current performance of Orders, Revenue and Profit against quarterly targets, these were created using measures constructed using DAX formulae. Maximum gauge value was set to the quarterly target for each measure, and conditional formatting was applied so the callout value would show red if the target it not met, and black if it is. 

An area chart was created to show the performance of different product categories over time. Total Revenue was plotted against Dates[Start of Quarter] with Products[Category] as the legend.

The top 10 products table was copied from the Executive summary page and formatted. 

A scatter graph was created to show the quantity of sales for each product category against profit per item. A calculated column was used to plot Profit per Item. Products[Total Quantity] was plotted against Products[Profit per Item] with Products[Description] as values and Products[Category] as the legend. 

A slicer filter toolbar was created to allow users to control how the data on the page are filtered. Two new vertical list slicers were created to enable the user to filter by Product Category from Products[Category] and Country from Stores[Country]. A slicer toolbar was created with these slicers and a back button, linked to a bookmark with the toolbar hidden to allow users to click back to the main report page. A filter button was created on the main report page, linked to a bookmark with the toolbar open to allows users to navigate to the slicer toolbar from the main report page. 

# Part 6, building the Stores Map page (milestone 8)
A map visual was created using the previously created geographical hierarchy with the Profit YTD measure as values. A tile style slicer was added with Stores[Country] as the field to allow users to filter by country or show all countries. 

A drillthrough page was created to allow users to quickly see an overview of a store's performance. A table was created to show the top 5 products based on total revenue, with columns: Description, Profit YTD, Total Orders, Total Revenue. A column chart showing the Total Orders by product category for the store was created. Gauges were created for Profit YTD against a profit target of 20% year-on-year growth vs. the same period in the previous year. An equivalent gauge was created for Revenue YTD. Measures were calculcated to derive profit and revenue targets. A card visual was created to show the currently selected store. 

A tooltip page was created to enable users to quickly see each stores Profit YTD performance against the profit target by hovering over a store on the map. The profit gauge visual created in the previous step was copied to the tooltip page. 

## Installation instructions

## Usage instructions

## File structure

## License information