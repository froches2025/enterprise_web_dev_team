# SQL-to-JSON Mapping Documentation

This document explains how each table in `database_setup.sql` maps to its corresponding JSON representation in `json_schemas.json`.

## 1. `users` → `User`
Each row in `users` maps directly to a `User` JSON object. `UserID` (int, PK) becomes `userId` in nested contexts; `Name` and `PhoneNumber` map one-to-one as strings. No transformation needed — this is a flat, non-nested entity.

## 2. `transactions` → `Transaction`
Each row in `transactions` maps to a `Transaction` object. `TransactionID`, `Amount`, and `TransactionDate` map directly. The `UserID` foreign key is **not** kept as a raw integer in API-facing JSON — instead, it is resolved and nested as a full `sender` object (see Complete_Transaction_Example), since API consumers need the user's name and phone number, not just an ID.

## 3. `transaction_categories` → `Transaction_Category`
Each row maps directly to a `Transaction_Category` object. `CategoryID` and `CategoryName` map one-to-one.

## 4. `transaction_category_mapping` → `categories` array
This junction table has no standalone JSON representation in API responses — it exists purely to resolve the many-to-many relationship between transactions and categories in the relational model. In JSON, its effect is represented by nesting a `categories` array directly inside the `Complete_Transaction_Example` object, containing the full category objects joined through this table rather than the raw ID pairs.

## 5. `system_logs` → `System_Log`
Each row maps to a `System_Log` object. `LogID`, `LogMessage`, and `LogDate` map directly. `UserID` is nullable in SQL (`ON DELETE SET NULL`), so the JSON `UserID` field also allows `null`. In the complete transaction example, related logs are nested as a `relatedLogs` array, joined on `UserID` matching the transaction's sender.

## Key design decision
Foreign keys in SQL become **nested objects or arrays** in JSON, not raw ID references. This matches how a real API consumer would want the data — a single request for a transaction returns everything needed (who sent it, what category it's in, any related log entries) without requiring additional round-trip queries.

---

# Data Dictionary

## Table: `users`
| Column | Type | Constraints | Description |
|---|---|---|---|
| UserID | INT | PK, AUTO_INCREMENT | Unique identifier for each user |
| Name | VARCHAR(100) | NOT NULL | Full name of the user |
| PhoneNumber | VARCHAR(20) | NOT NULL, UNIQUE | Contact phone number, must be unique |

## Table: `transactions`
| Column | Type | Constraints | Description |
|---|---|---|---|
| TransactionID | INT | PK, AUTO_INCREMENT | Unique identifier for each transaction |
| UserID | INT | NOT NULL, FK → users.UserID, ON DELETE CASCADE | The user who made the transaction |
| Amount | DECIMAL(10,2) | NOT NULL, CHECK (Amount > 0) | Transaction amount |
| TransactionDate | DATETIME | DEFAULT CURRENT_TIMESTAMP | When the transaction occurred |

## Table: `transaction_categories`
| Column | Type | Constraints | Description |
|---|---|---|---|
| CategoryID | INT | PK, AUTO_INCREMENT | Unique identifier for each category |
| CategoryName | VARCHAR(100) | NOT NULL, UNIQUE | Name of the transaction category |

## Table: `transaction_category_mapping` (junction table)
| Column | Type | Constraints | Description |
|---|---|---|---|
| TransactionID | INT | PK (composite), FK → transactions.TransactionID, ON DELETE CASCADE | Links to the transaction |
| CategoryID | INT | PK (composite), FK → transaction_categories.CategoryID, ON DELETE CASCADE | Links to the category |

Resolves the many-to-many relationship between `transactions` and `transaction_categories`.

## Table: `system_logs`
| Column | Type | Constraints | Description |
|---|---|---|---|
| LogID | INT | PK, AUTO_INCREMENT | Unique identifier for each log entry |
| UserID | INT | NULLABLE, FK → users.UserID, ON DELETE SET NULL | User associated with this log entry (nullable) |
| LogMessage | VARCHAR(255) | NOT NULL | Description of the logged event |
| LogDate | DATETIME | DEFAULT CURRENT_TIMESTAMP | When the log entry was created |
