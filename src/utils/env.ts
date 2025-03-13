// Detect environment and return the appropriate database URL
export function getDatabaseUrl() {
  // If running locally (not in Docker)
  if (process.env.NODE_ENV !== 'production') {
    return process.env.DATABASE_URL?.replace('db:5432', 'localhost:5432');
  }
  return process.env.DATABASE_URL;
} 