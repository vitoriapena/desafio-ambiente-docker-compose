# Astro Docker PostgreSQL Demo

A simple message board application built with Astro, Docker, and PostgreSQL.

## Features

- Server-side rendering with Astro
- PostgreSQL database for message storage
- Docker containerization
- Simple and clean UI
- Real-time message updates

## Prerequisites

- Docker
- Docker Compose
- Node.js (for local development)

## Getting Started

1. Clone the repository:
```bash
git clone <your-repo-url>
cd <repo-name>
```

2. Copy the example environment file:
```bash
cp .env.example .env
```

3. Start the application with Docker:
```bash
docker compose up --build
```

4. Visit `http://localhost:4321` in your browser

## Development

For local development:

1. Start only the database:
```bash
docker compose up db -d
```

2. Install dependencies:
```bash
npm install
```

3. Run the development server:
```bash
npm run dev
```

## License

MIT 