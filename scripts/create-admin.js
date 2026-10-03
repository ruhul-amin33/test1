// Usage: npm run create-admin -- you@example.com YourPassword
// Admin account banay (ba thakle password reset kore admin banay). Direct database e kaj kore.
require('dotenv').config();
const bcrypt = require('bcryptjs');
const mysql = require('mysql2/promise');
(async () => {
  const email = String(process.argv[2] || '').trim().toLowerCase();
  const password = String(process.argv[3] || '');
  if (!/^\S+@\S+\.\S+$/.test(email) || password.length < 6) {
    console.log('Usage: npm run create-admin -- you@example.com YourPassword   (password 6+ characters)'); process.exit(1);
  }
  const conn = await mysql.createConnection({ host: process.env.DB_HOST, port: Number(process.env.DB_PORT || 3306),
    user: process.env.DB_USER, password: process.env.DB_PASSWORD, database: process.env.DB_NAME, charset: 'utf8mb4' });
  const hash = await bcrypt.hash(password, 10);
  const [r] = await conn.query("UPDATE users SET password_hash = ?, role = 'admin' WHERE email = ?", [hash, email]);
  if (!r.affectedRows) await conn.query("INSERT INTO users (name,email,phone,password_hash,role) VALUES ('Shop Admin',?,'',?,'admin')", [email, hash]);
  await conn.end();
  console.log('Done. Admin login: ' + email + '  ->  open /#/admin');
})().catch((e) => { console.error('Failed:', e.message); process.exit(1); });
