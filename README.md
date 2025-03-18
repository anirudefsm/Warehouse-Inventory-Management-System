# Warehouse Inventory Management System

This repository contains the design, implementation, and analysis of a **Warehouse Inventory Management System**. The system is designed to manage inventory, track orders, monitor supplier performance, and analyze customer behavior. The database is built using MySQL and includes CRUD operations, stress testing, and an Entity-Relationship Diagram (ERD) for better understanding.

## Repository Structure

- **Warehouse Inventory Management System - SQL**: This folder contains all the SQL files related to the database, including table creation, CRUD operations, and stress testing.
  - `TableCreation_WarehouseInvMgmtSys.sql`: SQL script for creating the database tables.
  - `AddingRecords_WarehouseInvMgmtSys.sql`: SQL script for inserting sample records into the database.
  - `R&U-WarehouseInvMgmtSys.sql`: SQL script for performing read and update operations on the database.
  - `StressTesting_WarehouseInvMgmtSys.sql`: SQL script for stress testing the database to ensure it can handle high transaction volumes.
  
- **ER Diagram**: The main repository contains the ER Diagram of the database, which provides a visual representation of the database schema and relationships between tables.

## Database Overview

The database consists of **17 tables** that manage various aspects of warehouse inventory, including products, suppliers, orders, shipments, customers, and employees. The system is designed to handle inventory tracking, order management, supplier performance analysis, and customer behavior insights.

### Key Features:
- **Inventory Management**: Track product quantities, reorder levels, and inventory adjustments.
- **Order Management**: Manage customer orders, order items, and order statuses.
- **Supplier Management**: Monitor supplier performance and shipment details.
- **Customer Insights**: Analyze customer purchasing trends and lifetime value (CLTV).
- **Cycle Counts**: Ensure inventory accuracy by comparing system quantities with actual quantities.
- **Returns Management**: Track product returns and analyze return rates.

## How to Use

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/Warehouse-Inventory-Management-System.git
   ```

2. **Navigate to the SQL Folder**:
   ```bash
   cd Warehouse-Inventory-Management-System/Warehouse Inventory Management System - SQL
   ```

3. **Run the SQL Scripts**:
   - Execute `TableCreation_WarehouseInvMgmtSys.sql` to create the database tables.
   - Execute `AddingRecords_WarehouseInvMgmtSys.sql` to insert sample data.
   - Execute `R&U-WarehouseInvMgmtSys.sql` to perform read and update operations.
   - Execute `StressTesting_WarehouseInvMgmtSys.sql` to test the database under high load conditions.

4. **Explore the ER Diagram**: The ER Diagram is available in the main repository for a visual understanding of the database schema.

## Key Insights and Recommendations

- **Focus on High-Performing Categories**: Electronics is the most profitable category. Allocate more resources to this category to maximize revenue.
- **Address High Return Rates**: Investigate the root cause of high return rates and implement stricter quality control measures.
- **Improve Inventory Management**: Conduct regular audits for products with high discrepancies and optimize stock levels for slow-moving categories.
- **Enhance Customer Retention**: Focus on retaining high-value customers through loyalty programs and personalized offers.
- **Optimize Supplier Performance**: Explore opportunities to reduce fulfillment times and negotiate better terms with suppliers.
- **Database Stress Testing**: Ensuring the database can handle high transaction volumes while maintaining data integrity and performance was a key challenge. The database was rigorously tested for **1NF (First Normal Form)** compliance to eliminate redundancy and improve efficiency.

--

## Challenges Faced

1. **Database Design Complexity**:
   - Designing a database with 17 tables and ensuring proper normalization (1NF compliance) was a significant challenge. The database had to be structured to eliminate redundancy while maintaining efficient performance.

2. **Stress Testing**:
   - Simulating high transaction volumes to test the database's performance under load was challenging. The stress testing script had to ensure that the database could handle concurrent operations without data corruption or performance degradation.

3. **Data Integrity**:
   - Ensuring data integrity across multiple tables with foreign key constraints required careful planning and testing. The CRUD operations had to be designed to maintain consistency across related tables.

---


## Conclusion

This Warehouse Inventory Management System provides a robust solution for managing inventory, orders, suppliers, and customers. The database design adheres to **1NF (First Normal Form)**, ensuring data integrity and efficient performance. By addressing the challenges and implementing the recommended strategies, the system can drive long-term growth and profitability.

For any questions or contributions, feel free to open an issue or submit a pull request.

---
