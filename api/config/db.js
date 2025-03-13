const { Pool } = require('pg');

// Use pooled connection by default, fall back to non-pooled if needed
const connectionString = process.env.POSTGRES_URL || process.env.DATABASE_URL;

const pool = new Pool({
    connectionString,
    ssl: {
        rejectUnauthorized: true
    }
});

// Wrapper to maintain compatibility with existing code
const wrapDB = {
    query: async (sql, params = []) => {
        const client = await pool.connect();
        try {
            const result = await client.query(sql, params);
            return [result.rows];
        } finally {
            client.release();
        }
    }
};

module.exports = wrapDB;