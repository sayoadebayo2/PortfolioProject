# US Wage Analysis SQL Project

## Project Description
The US Wage Analysis SQL Project provides a comprehensive view of wage differences between college graduates and high school graduates in the United States from 1973 to 2022. This project is based on data sourced from the Economic Policy Institute's State of Working America Data Library and includes adjusted wages.

The project's goal is to analyze and derive insights from this dataset, exploring wage disparities over time and across different dimensions.

## Table of Contents
- [Getting Started](#getting-started)
- [Database Schema](#database-schema)
- [SQL Scripts](#sql-scripts)
- [Data Source](#data-source)
- [Queries and Analysis](#queries-and-analysis)
- [Results and Visualizations](#results-and-visualizations)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)
- [Authors](#authors)

## Set Up
To get started with this project, follow these steps:

1. Clone the repository to your local machine.
2. Set up a SQL database (e.g., MySQL or PostgreSQL).
3. Import the dataset from the provided CSV file (`college_wage_premium.xlsv`) into your database.
4. Run the SQL scripts provided in the `sql_scripts` directory to perform data analysis.

## Database Schema
The project database includes the following tables:

- `wage_data`: Contains wage data, including the year, median hourly wages for high school graduates, college graduates, and other demographic information.

## SQL Scripts
The project includes a set of SQL scripts in the `sql_scripts` directory:

- `sqlproject.sql`: Contains a series of SQL queries for data analysis and insights.

## Data Source
The dataset used in this project is sourced from the Economic Policy Institute's State of Working America Data Library and downloaded from kaggle.com

## Queries and Analysis
The SQL queries in the `sqlproject.sql` file perform various analyses, including:

- Comparing median wages between different categories (e.g., college graduates vs. high school graduates, different years).
- Analyzing wage trends over the years to understand the changes in wage disparities.
- Identifying geographic regions or states where wage differences are more pronounced.
- Investigating whether the wage gap has been narrowing or widening for different genders.
- Calculating trend metrics, such as annual growth rates in the wage gap.
- Analyzing the overall trend in the wage gap between all college graduates and high school graduates, including gender, over the years.


## Acknowledgments
- The Economic Policy Institute for providing the dataset.
- Sayo Adebayo for contributions to the project.

## Authors
- Sayo Adebayo - Project Lead - sayoadebayo82@gmail.com
