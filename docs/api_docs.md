# MoMo REST API Documentation

Base URL: `http://localhost:8000`
Authentication: Basic Authentication (`Authorization: Basic <base64_encoded_credentials>`)

---

## 1. Get All Transactions
* **Endpoint:** `GET /transactions`
* **Description:** Retrieves a list of all parsed MoMo SMS transactions.
* **Headers:** `Authorization: Basic <credentials>`
* **Success Response (200 OK):**
  ```json
  [
    {
      "id": 1,
      "transaction_type": "incoming_money",
      "amount": 2000,
      "sender": "Jane Smith",
      "receiver": "account_owner",
      "timestamp": "2024-05-10T16:30:51"
    }
  ]
  ```

- **Error Codes:**

- `401 Unauthorized` (Missing or invalid credentials)

## 2. Get Transaction by ID

- **Endpoint:** `GET /transactions/{id}`
- **Description:** Retrieves a single transaction object by its unique sequential integer ID.
- **Headers:** `Authorization: Basic <credentials>`
- **Success Response (200 OK):**

```json
{
  "id": 1,
  "transaction_type": "incoming_money",
  "amount": 2000,
  "sender": "Jane Smith",
  "receiver": "account_owner",
  "timestamp": "2024-05-10T16:30:51"
}
```

- **Error Codes:**

- `400 Bad Request` (Invalid ID format)
- `401 Unauthorized` (Missing or invalid credentials)
- `404 Not Found` (Transaction ID does not exist)

## 3. Create a Transaction

- **Endpoint:** `POST /transactions`
- **Description:** Adds a new transaction record to the system. A unique ID is auto-assigned.
- **Headers:**

- `Authorization: Basic <credentials>`
- `Content-Type: application/json`
- **Request Example:**

```json
{
  "transaction_type": "transfer",
  "amount": 5000,
  "sender": "account_owner",
  "receiver": "Alex Doe",
  "timestamp": "2024-06-01T10:15:00"
}
```

- **Success Response (201 Created):**

```json
{
  "id": 1694,
  "transaction_type": "transfer",
  "amount": 5000,
  "sender": "account_owner",
  "receiver": "Alex Doe",
  "timestamp": "2024-06-01T10:15:00"
}
```

- **Error Codes:**

- `400 Bad Request` (Malformed JSON or missing required fields)
- `401 Unauthorized` (Missing or invalid credentials)

## 4. Update a Transaction

- **Endpoint:** `PUT /transactions/{id}`
- **Description:** Updates an existing transaction record by its ID. The primary ID cannot be changed.
- **Headers:**

- `Authorization: Basic <credentials>`
- `Content-Type: application/json`
- **Request Example:**

```json
{
  "transaction_type": "transfer",
  "amount": 5500,
  "sender": "account_owner",
  "receiver": "Alex Doe",
  "timestamp": "2024-06-01T10:15:00"
}
```

- **Success Response (200 OK):**

```json
{
  "id": 1,
  "transaction_type": "transfer",
  "amount": 5500,
  "sender": "account_owner",
  "receiver": "Alex Doe",
  "timestamp": "2024-06-01T10:15:00"
}
```

- **Error Codes:**

- `400 Bad Request` (Malformed JSON or invalid ID format)
- `401 Unauthorized` (Missing or invalid credentials)
- `404 Not Found` (Transaction ID does not exist)

## 5. Delete a Transaction

- **Endpoint:** `DELETE /transactions/{id}`
- **Description:** Removes a transaction record from the system database by its ID.
- **Headers:** `Authorization: Basic <credentials>`
- **Success Response (204 No Content):** (Empty body)
- **Error Codes:**

- `400 Bad Request` (Invalid ID format)
- `401 Unauthorized` (Missing or invalid credentials)
- `404 Not Found` (Transaction ID does not exist)
