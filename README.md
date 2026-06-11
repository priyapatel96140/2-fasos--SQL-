# 2-fasos--(SQL)
# Fasos Order & Delivery Analysis (SQL)

## Project Overview
This project involves an in-depth data analysis of Fasos (a popular cloud kitchen/food delivery brand) operations using MySQL. The analysis focuses on metrics surrounding order volumes, customer behavior optimization, kitchen operational efficiency, driver delivery performance, and product customization patterns.

By querying and transforming raw transactional data, these scripts solve key business bottlenecks—helping to understand delivery lag times, customer retention, and the impact of food customization on overall sales.


## Analysis Framework & Key Questions
The project is split into distinct operational pillars, addressing the specific business questions answered in the SQL scripts:

### 1. Customer & Order Metrics
* How many total rolls were ordered?
* How many unique customers placed orders?
* How many successful orders were delivered by each driver?
* How many of each type of roll (e.g., Veg vs. Non-Veg) were delivered successfully?
* What is the maximum number of rolls ordered by a single customer in a single transaction?

### 2. Food Customization Insights
* How many delivered rolls had extra ingredients, exclusions (no ingredients), or both?
* How many orders were placed with no changes at all to the standard recipe?
* What is the total count of rolls ordered with specific ingredient modifications for each customer?

### 3. Driver & Operational Efficiency
* What was the exact volume of orders placed for each hour of the day?
* What is the weekly breakdown of order volumes?
* How long does it take (in minutes) for a driver to arrive at the kitchen after a customer places an order?
* Is there a correlation between the number of rolls in an order and the time it takes to prepare the food?
* What is the average distance traveled by drivers for each customer?

### 4. Delivery Performance & Pricing Metrics
* What is the speed difference (average speed) between drivers across different deliveries?
* What is the successful delivery percentage for each driver?
* If a standard roll costs a fixed amount, what is the total revenue generated so far?
* How does adding extra ingredients affect total revenue if extras cost an additional fee?


## Database Schema & Structure
The analysis utilizes a relational database structure representing a typical food-tech operational pipeline:
* **`customer_orders`:** Captures detailed transaction logs including `order_id`, `customer_id`, `roll_id`, and real-time custom specifications (`not_include_items`, `extra_items`).
* **`driver_order`:** Tracks logistics data including `driver_id`, `pickup_time`, `distance`, `duration`, and delivery `cancellation` records.
* **`ingredients` & `rolls`:** Handles inventory definitions, mapping specific ingredients to their respective roll types.


## Key Technical Skills Demonstrated
* **Data Cleaning & Handling Nulls:** Replacing inconsistent data entry formats (e.g., mixing empty strings, `'null'`, and actual `NULL` values) to ensure accurate aggregate calculations.
* **Date & Time Calculations:** Utilizing functions like `TIMESTAMPDIFF` and `DATE_ADD` to precisely measure operational bottlenecks and delivery driver speeds.
* **Advanced Aggregations:** Utilizing `CASE WHEN` logic inside `SUM` and `COUNT` functions to run conditional data metrics across highly customized orders.
* **String Manipulation & Parsing:** Breaking down comma-separated text fields to analyze individual ingredient changes chosen by customers.


## Author

Priya Patel  
Aspiring Data Analyst  
Email: priyapatel18217@gmail.com  
GitHub: [priyapatel96140](https://github.com/priyapatel96140)  

If you like this project, feel free to give it a star!
