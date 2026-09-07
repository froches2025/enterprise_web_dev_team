# EnterpriseWebDevTeamwork

## Project Description
An enterprise-level fullstack application designed to process Mobile Money (MoMo) SMS data in XML format, clean and categorize transactions, store data in a SQLite relational database, and visualize metrics through an interactive frontend dashboard.

## Team Members
- Favour Mieye Michael - Froches
- Annabel Kemasuode - akemasuode-crypto
- Hussaina Abubakar Shehu - hussaina3

## System Architecture
Our high-level system architecture illustrates the data flow from raw XML ingestion through the ETL pipeline, SQLite storage, and frontend visualization.
- **Architecture Diagram:** [View Architecture Diagram File](./architecture.png)

## Project Management
We are tracking our agile sprint progress, task distribution, and backlog using our shared Trello Scrum board.
- **Scrum Board:** [EnterpriseWebDevTeamwork Trello Board](https://trello.com/b/aj79kn2t/enterprisewebdevteamwork)

## Project Structure
```text
├── README.md
├── architecture.png
├── .env.example
├── requirements.txt
├── index.html
├── web/
│   ├── styles.css
│   └── chart_handler.js
├── data/
│   ├── raw/
│   ├── processed/
│   └── db.sqlite3
├── etl/
├── scripts/
└── tests/
