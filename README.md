# TODO:
- Model test
- Implement API
- JWT auth
- OpenAPI doc (swagger)

# Rails Movie API

A RESTful movie API with OpenAPI and JWT auth.

## Tech Stack

- Ruby 3.3.8 / Rails 8.0.2
- PostgreSQL 16.9
- Docker 28.3.2 / Docker Compose v2.38.2

## Setup Instructions

### Using Docker

1. Clone the repository
```bash
git clone <repository-url>
cd rails-movie-api
```

2. Start the application
```bash
docker compose up
```

3. Visit http://localhost:3000

### Local Development

1. Install dependencies
```bash
bundle install
```

2. Setup database
```bash
bin/rails db:prepare # (db:create + db:migrate + db:seed)
```

3. Start the server
```bash
bin/rails server
```

---
## Database Schema

### ER Diagram

```mermaid
erDiagram
    User {
        bigint id PK
        string username "NOT NULL, UNIQUE"
        string password_digest "NOT NULL"
    }

    Movie {
        bigint id PK
        string title "NOT NULL"
        text description
        integer release_year
    }

    Watchlist {
        bigint id PK
        bigint user_id FK "NOT NULL"
        bigint movie_id FK "NOT NULL"
    }

    User ||--o{ Watchlist : "has_many"
    Movie ||--o{ Watchlist : "has_many"
    Watchlist }o--|| User : "belongs_to"
    Watchlist }o--|| Movie : "belongs_to"
```

*Note: Standard Rails timestamps (created_at, updated_at) are omitted from the diagram for clarity*

### Constraints
- `(user_id, movie_id)` combination must be unique in Watchlists


---

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
