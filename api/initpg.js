require('dotenv').config();
const fs = require('fs');
const path = require('path');
const { Pool } = require('pg');

// Use non-pooled connection for schema initialization
const connectionString = process.env.POSTGRES_URL_NON_POOLING;

const pool = new Pool({
    connectionString,
    ssl: {
        rejectUnauthorized: true
    }
});

async function initDatabase() {
    try {
        const client = await pool.connect();
        try {
            // Read and execute schema
            const schemaPath = path.join(__dirname, 'database.pg.sql');
            const schema = fs.readFileSync(schemaPath, 'utf8');
            await client.query(schema);
            console.log('Database initialized successfully!');
        } finally {
            client.release();
        }
    } catch (error) {
        console.error('Error initializing database:', error);
    } finally {
        await pool.end();
    }
}

initDatabase(); 