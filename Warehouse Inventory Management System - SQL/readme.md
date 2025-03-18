# Warehouse Inventory Management System - SQL

This folder contains all the SQL files related to the **Warehouse Inventory Management System** database. These scripts include table creation, CRUD operations (Create, Read, Update, Delete), and stress testing to ensure the database can handle high transaction volumes efficiently.

## SQL Files Overview

1. **`TableCreation_WarehouseInvMgmtSys.sql`**:
   - This script contains the SQL commands to create all the tables in the database. It defines the structure of the database, including primary keys, foreign keys, and constraints.

2. **`AddingRecords_WarehouseInvMgmtSys.sql`**:
   - This script is used to insert sample records into the database tables. It populates the tables with initial data for testing and analysis purposes.

3. **`R&U-WarehouseInvMgmtSys.sql`**:
   - This script includes SQL commands for performing **Read** and **Update** operations on the database. It allows you to query data and update existing records.

4. **`StressTesting_WarehouseInvMgmtSys.sql`**:
   - This script is designed to stress-test the database by simulating high transaction volumes. It ensures that the database can handle heavy loads while maintaining data integrity and performance.

---

## How to Use

1. **Clone the Repository**:
   If you haven't already, clone the repository to your local machine:
   ```bash
   git clone https://github.com/your-username/Warehouse-Inventory-Management-System.git
   ```

2. **Navigate to the SQL Folder**:
   Move into the SQL folder where the scripts are located:
   ```bash
   cd Warehouse-Inventory-Management-System/Warehouse Inventory Management System - SQL
   ```

3. **Run the SQL Scripts**:
   Execute the SQL scripts in the following order:

   - **Step 1**: Create the database tables by running:
     ```bash
     mysql -u your_username -p < TableCreation_WarehouseInvMgmtSys.sql
     ```

   - **Step 2**: Insert sample records into the tables by running:
     ```bash
     mysql -u your_username -p < AddingRecords_WarehouseInvMgmtSys.sql
     ```

   - **Step 3**: Perform read and update operations by running:
     ```bash
     mysql -u your_username -p < R&U-WarehouseInvMgmtSys.sql
     ```

   - **Step 4**: Stress-test the database by running:
     ```bash
     mysql -u your_username -p < StressTesting_WarehouseInvMgmtSys.sql
     ```

4. **Verify the Results**:
   After running the scripts, you can verify the results by querying the database directly or using a database management tool like MySQL Workbench.

---

## Challenges Faced

1. **Database Design Complexity**:
   - Designing a database with 17 tables and ensuring proper normalization (1NF compliance) was a significant challenge. The database had to be structured to eliminate redundancy while maintaining efficient performance.

2. **Stress Testing**:
   - Simulating high transaction volumes to test the database's performance under load was challenging. The stress testing script had to ensure that the database could handle concurrent operations without data corruption or performance degradation.

3. **Data Integrity**:
   - Ensuring data integrity across multiple tables with foreign key constraints required careful planning and testing. The CRUD operations had to be designed to maintain consistency across related tables.

---

## Key Features of the SQL Scripts

- **Table Creation**: The `TableCreation_WarehouseInvMgmtSys.sql` script defines the database schema, including primary keys, foreign keys, and constraints to ensure data integrity.
- **Sample Data**: The `AddingRecords_WarehouseInvMgmtSys.sql` script populates the database with sample data for testing and analysis.
- **CRUD Operations**: The `R&U-WarehouseInvMgmtSys.sql` script allows you to perform read and update operations on the database, ensuring that the system can handle real-world scenarios.
- **Stress Testing**: The `StressTesting_WarehouseInvMgmtSys.sql` script simulates high transaction volumes to test the database's performance and scalability.

---

## Conclusion

This folder contains all the necessary SQL scripts to set up, populate, and test the **Warehouse Inventory Management System** database. The scripts are designed to ensure the database is robust, scalable, and capable of handling high transaction volumes while maintaining data integrity.

For any questions or issues, feel free to open an issue or submit a pull request.

---
