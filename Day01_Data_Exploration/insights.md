Key Learnings

Exploring the database revealed a large number of tables organized by schema, such as Sales, Production, Person, and Purchasing. This highlights how enterprise databases separate data by business domain.

Fact vs Dimension Understanding

In the Data Warehouse, tables such as FactInternetSales and FactResellerSales act as fact tables because they store measurable business events like sales. Tables such as DimCustomer, DimProduct, and DimDate serve as dimension tables that provide descriptive context for analysis.

In the OLTP database, tables like SalesOrderHeader and SalesOrderDetail function similarly to fact tables, while Product, Customer, and Person behave like dimension-style tables.

Primary and Foreign Keys

Primary and foreign key exploration made the relationships between tables explicit. Understanding these relationships is critical for building accurate joins and avoiding duplicated or missing records in analysis.

Reflection

This exercise reinforced that good SQL analysis starts before writing complex queries. Spending time understanding table structure, keys, and relationships reduces errors later and makes analytical queries more intentional and reliable.As a data analyst, our real skill includes:

Knowing which tables to join

Knowing why they are joined

Knowing what grain the data is at
