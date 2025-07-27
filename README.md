# Rails Movie API

Some description.

## Development Environment

### Ruby/Rails
- Ruby 3.3.8
- Rails 8.0.2
- PostgreSQL 16.9

### Docker
- Docker 28.3.2
- Docker Compose v2.38.2

### Development Tools
- Bundler 2.7.1
- RuboCop 1.79.0

## Getting Started

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
