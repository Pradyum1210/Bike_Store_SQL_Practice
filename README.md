# 📘 Bike Store SQL Project – Complete Database Analysis

This project contains SQL queries written for the **Bike Store Database**, covering everything from basic SELECT statements to advanced SQL concepts such as **joins, aggregate functions, window functions, subqueries, and CTEs**.

It is ideal for SQL learners, beginners preparing for interviews, and anyone practicing real-world database analytics.

---

## 🏗️ 1. Database Used

**Database Name:** `bike_store`

The database includes multiple relational tables representing a real retail environment.

### 📂 Bike Store Database Structure

| Table Name     | Description |
|----------------|-------------|
| `customers`    | Customer personal and contact details |
| `products`     | All products sold by the store |
| `categories`   | Product categories (e.g., Road, Mountain, Electric) |
| `brands`       | Bicycle brand names |
| `orders`       | Customer orders with date and staff info |
| `order_items`  | List of purchased items for each order |
| `stores`       | Store branches and their locations |
| `staffs`       | Employees working in each store |
| `stocks`       | Available stock per product per store |

---

## 🧾 2. Query Highlights

### 🔹 **Basic SQL Queries**
- Retrieve all customer details  
- Filter products based on price range  
- Sort customers alphabetically  
- Display orders from a specific year  
- Show all store contact details  

---

### 🔹 **Joins & Filtering**
- Fetch product details along with their **brand names**  
- Get products with **low stock levels**  
- Retrieve complete order details with **customer + store info**  
- Join multiple tables for combined insights  

---

### 🔹 **Aggregate & Summary Queries**
- Count how many products exist  
- Count total orders placed by each customer  
- Find the **top most expensive** products  
- Calculate **total sales per store** (SUM of order amounts)  

---

### 🔹 **Grouping & HAVING Clause**
- Customers with **more than 3 orders**  
- Total quantity ordered for each product  
- Minimum/maximum price per brand  
- Customers whose spending is **above the average**  

---

## 📊 3. Advanced SQL Components

### 🏅 **Window Functions**
Used for ranking and analytical insights, such as:

- Ranking brands based on **average product price**  
- Identify **best-selling employee** in each store  
- Determine **top loyal customers** based on order count  

---

### 🧩 **Common Table Expressions (CTEs)**
CTEs make complex queries clean and readable. Examples include:

- Calculating **total revenue per customer**  
- Finding the **latest order per customer** using  
  `CTE + ROW_NUMBER()`  
- Generating temporary result sets for step-by-step analysis  

---

## 📌 4. Key Problem Statements Solved

| Category | Example Problems Solved |
|----------|---------------------------|
| **Basic Queries** | Show all customers, filter products, sort results |
| **Intermediate Queries** | Joins, grouping, conditional filtering |
| **Advanced SQL** | Window functions, ranking, subqueries, CTE-based analytics |

---

## 🎯 5. Skills Practiced

- SQL querying & optimization  
- Analytical problem solving using SQL  
- Real-world business querying scenarios  

---

## 🛠️ 6. Tools & Technologies
- MySQL 
- SQL Workbench / pgAdmin / SSMS  
- Bike Store sample dataset  

---

