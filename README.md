# Enterprise Web Development: Building and Securing a REST API

## Project Description
An enterprise-level fullstack application designed to process Mobile Money (MoMo) SMS data in XML format, clean and categorize transactions, store data in a SQLite relational database, and visualize metrics through an interactive frontend dashboard.

## Team Members & Roles
- **Favour Mieye Michael** - Froches (Team Lead / DevOps / API Server Routing)
- **Annabel Kemasuode** - akemasuode-crypto (Data Parsing & DSA Implementation)
- **Hussaina Abubakar Shehu** - hussaina3 (Authentication, Security & Testing)

Team Task Sheet 1: [[https://docs.google.com/spreadsheets/d/1yz_lTUDztAgy1Ys5omRiPxsNjN_3dMH-DpGBZzNnlh8/edit?usp=sharing](https://docs.google.com/spreadsheets/d/1yz_lTUDztAgy1Ys5omRiPxsNjN_3dMH-DpGBZzNnlh8/edit?usp=sharing)]
Team Task Sheet 2: [[https://docs.google.com/spreadsheets/d/1acUvl2skJErdZpfmC4M6IhVHdun8ko9jWr3QF0tPqhA/edit?usp=sharing](https://docs.google.com/spreadsheets/d/1acUvl2skJErdZpfmC4M6IhVHdun8ko9jWr3QF0tPqhA/edit?usp=sharing)]

## Project Overview
This project processes Mobile Money (MoMo) SMS data in XML format, cleans and categorizes transactions, stores the results in a SQLite database, and visualizes metrics through an interactive frontend dashboard. It also documents the REST API contract, uses Basic Authentication for protected endpoints, and includes an empirical comparison of Linear Search and Dictionary Lookup.

## Setup & Running Instructions

1. **Clone the repository:**
    ```bash
    git clone https://github.com/froches2025/enterprise_web_dev_team.git
    cd enterprise_web_dev_team
    ```
2. **Ensure the source data is present:**
    Place `modified_sms_v2.xml` in docs folder before running the ETL or benchmark commands.
3. **Run the DSA benchmark:**
    ```bash
    python3 dsa/benchmark.py
    ```
4. **Serve the frontend:**
    ```bash
    python3 -m http.server 8000
    ```
    Then open `http://localhost:8000` in a browser.

The documented API endpoints are available in [docs/api_docs.md](docs/api_docs.md).

## System Architecture
Our high-level system architecture illustrates the data flow from raw XML ingestion through the ETL pipeline, SQLite storage, and frontend visualization.
- **Architecture Diagram:** [View Architecture Diagram File](./architecture.png)

## Project Management
We are tracking our agile sprint progress, task distribution, and backlog using our shared Trello Scrum board.
- **Scrum Board:** [EnterpriseWebDevTeamwork Trello Board](https://trello.com/b/aj79kn2t/enterprisewebdevteamwork)

## Project Structure
```text
├── README.md
├── api
│   ├── __init__.py
│   ├── app.py
│   ├── db.py
│   └── schemas.py
├── architecture.png
├── data
│   ├── db.sqlite3
│   ├── logs
│   │   ├── dead_letter
│   │   └── etl.log
│   ├── processed
│   │   └── dashboard.json
│   └── raw
├── database
├── docs
│   └── ERD_Diagram.png
├── etl
│   ├── __init__.py
│   ├── categorize.py
│   ├── clean_normalize.py
│   ├── config.py
│   ├── load_db.py
│   ├── parse_xml.py
│   └── run.py
├── examples
├── index.html
├── requirements.txt
├── scripts
│   ├── export_json.sh
│   ├── run_etl.sh
│   └── serve_frontend.sh
├── tests
│   ├── test_categorize.py
│   ├── test_clean_normalize.py
│   └── test_parse_xml.py
└── web
    ├── chart_handler.js
    └── styles.css

14 directories, 27 files
```

The repository also contains the DSA implementation in `/dsa`, visual test evidence in `/screenshots`, API endpoint documentation in `/docs/api_docs.md`, and the AI usage record in `/docs/ai_usage_log.md`.

## Submission Links

- **GitHub Repository:** [https://github.com/froches2025/enterprise_web_dev_team](https://github.com/froches2025/enterprise_web_dev_team)
- **Team Participation Sheet:** [https://docs.google.com/spreadsheets/d/1acUvl2skJErdZpfmC4M6IhVHdun8ko9jWr3QF0tPqhA/edit?usp=sharing](https://docs.google.com/spreadsheets/d/1acUvl2skJErdZpfmC4M6IhVHdun8ko9jWr3QF0tPqhA/edit?usp=sharing)
- **PDF Design Report:** [https://drive.google.com/file/d/1_J0xTLtt_9M6_4U0vsDGnw_mhG-Qh1um/view?usp=sharing](https://drive.google.com/file/d/1_J0xTLtt_9M6_4U0vsDGnw_mhG-Qh1um/view?usp=sharing)

## Database Design Rationale

To establish a solid foundation for our codebase, we separated the MoMo SMS data into four distinct entities: Users, Transactions, Transaction_Categories, and System_Logs. Giving each entity its own individual table makes the data much easier to filter and manage. For example, if the application needs to locate a user's profile to display a greeting, the code can query the Users table directly without having to sort through thousands of unrelated transaction records. This separation of concerns prevents data duplication and keeps our queries highly efficient.

Furthermore, we identified a many-to-many relationship between transactions and their classifications. Because a single transaction can fall under multiple categories (such as tagging an item as both a 'purchase' and a 'gift'), and a single category applies to many transactions, we introduced the Transaction_Category_Mapping table. This junction table serves as a clean intersection between Transactions and Transaction_Categories. It organizes the data securely, avoids cyclic data calls, and makes it significantly easier to sort and filter records by specific categories in the future.

Finally, to maintain strict data integrity, we assigned Primary Keys (PK) to uniquely identify every record within its respective table, and Foreign Keys (FK) to securely link our relational tables together. The System_Logs table was intentionally kept independent so it can record system errors and activities without interfering with the core financial data structure.