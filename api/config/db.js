const { Pool } = require('pg');

const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: {
        rejectUnauthorized: false
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