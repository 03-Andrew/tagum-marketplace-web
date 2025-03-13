const Database = require('better-sqlite3');
const path = require('path');

const dbPath = path.join(__dirname, '..', 'database.sqlite');
const db = new Database(dbPath);

// Enable foreign keys
db.pragma('foreign_keys = ON');

// Helper function to wrap SQLite queries to match MySQL2's promise interface
const wrapDB = {
    query: (sql, params = []) => {
        try {
            // For SELECT queries
            if (sql.trim().toLowerCase().startsWith('select')) {
                const stmt = db.prepare(sql);
                const rows = stmt.all(params);
                return Promise.resolve([rows]);
            }
            // For INSERT, UPDATE, DELETE queries
            else {
                const stmt = db.prepare(sql);
                const result = stmt.run(params);
                return Promise.resolve([result]);
            }
        } catch (error) {
            return Promise.reject(error);
        }
    }
};

module.exports = wrapDB;