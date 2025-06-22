# Print-on-Demand Order Manager

## Overview
This MySQL project models a print-on-demand order management system. It includes schema definitions, sample data, and essential SQL queries for managing users, products, orders, inventory, and order statuses.

## Schema Highlights
- **users**: Stores both customers and staff/admins with role and soft delete support.
- **products**: Catalog of customizable products with inventory tracking.
- **orders, order_items**: Handles multiple items per order.
- **order_status**: Tracks order progress over time.
- **order_audit**: Logs changes to orders.
- **shipping_addresses**: Supports multiple addresses per user.
- **order_returns**: Handles refunds and return reasons.

## Features Covered
- Normalized schema with foreign keys and ENUMs.
- Sample data to illustrate real use cases.
- SQL queries for placing, tracking, and reporting on orders.
- Bonus: return/refund tracking and soft deletes.

## How to Use
1. Run the SQL file in a MySQL 8.0+ environment.
2. Review the comments for understanding schema and flow.
3. Execute queries at the bottom to test functionality.

