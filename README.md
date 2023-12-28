## Project Overview
In this project, I undertook the transformation of the AdventureWorks database, an operational data store (ODS) from Microsoft, into a robust Dimensional Data Warehouse. Leveraging the Galaxy Schema methodology, I implemented a structured and efficient model that facilitated seamless analysis and reporting.

## Objectives
The primary objective was to convert the existing transactional database into a more accessible and optimized form for analytical purposes. This involved the strategic use of SSIS (SQL Server Integration Services) as the ETL (Extract, Transform, Load) tool to handle the data migration and transformation processes.

## Technologies And Concepts
- SQL Server
- SSIS (SQL Server Integration Services)
- Dimensional Modeling
- SCD

## Source and Database
[AdventureWorks2019 OLTP](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms)
Microsoft has made available an example database called AdventureWorks that is intended for testing and demonstrating different Microsoft SQL Server functionalities.


## Dimensional Modeling Steps

1. **Identifying Business Process:**
   - Recognized the core business process, focusing on Point of Sale (POS) transactions within the AdventureWorks database.

2. **Declaring the Grain:**
   - Defined the grain of the data, honing in on the line item level to ensure granularity and specificity in the data model.

3. **Identifying Dimensions:**
   - Recognized key dimensions crucial for analysis, including Product, Customer, Territory, and Date.

4. **Identifying Facts and Measures:**
   - Determined the facts and measures of interest, with a specific focus on online and in-store sales. Implemented a Galaxy schema featuring two distinct fact tables to accommodate both types of sales.

![DM](https://github.com/omarkhalled/DataWarehouse-GalaxySchema-SSIS/blob/main/ScreenShoots/DM.png?raw=true)
 
## ETL Workflow
As part of the ETL process, I employed SSIS to extract data from the source, apply necessary transformations, and load it into the newly designed Dimensional Data Warehouse. This not only involved the migration of data but also included intricate transformations to ensure data integrity, quality, and consistency.


## ETL Steps

1. **Acquiring Source Data:**
   - Extracted data from the source, initiating the ETL process by gathering information from the AdventureWorks database.

2. **Transforming Source Data:**
   - Conducted comprehensive transformations on the source data, addressing missing values and handling null values to ensure data quality.

3. **Debugging and Data Validation:**
   - Debugged the ETL process, meticulously validating each step. Ensured the integrity of records by cross-verifying source table records with the transformed data.

4. **Implementing Slowly Changing Dimensions:**
   - Leveraged expertise in Slowly Changing Dimensions (SCD) to implement both Type 1 and Type 2 changes. Managed updates and historical tracking within SSIS.

5. **Loading Transformed Data:**
   - Loaded the transformed data into the Destination Data Warehouse, conducting further debugging and testing to guarantee accuracy and completeness.

These steps encompassed a holistic approach, from understanding the business processes to implementing advanced ETL techniques, resulting in a well-structured and optimized Dimensional Data Warehouse.

## [Screenshots](ScreenShoots)
