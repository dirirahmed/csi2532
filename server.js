const express = require('express');
const { Pool } = require('pg');
require('dotenv').config();

const app = express();
const port = 3000;

const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_DATABASE,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

app.set('view engine', 'ejs');
app.use(express.static('public'));
app.use(express.urlencoded({ extended: true }));

// Home Route
app.get('/', (req, res) => {
    res.render('recherche');
});

// Search Logic / Logique de recherche
app.get('/rechercher', async (req, res) => {
    try {
        const { dateDebut, dateFin, capacite, categorie, prixMin, prixMax, chaine } = req.query;
        
        // Handling instructions for search by dates, capacity, chain, category, and price [cite: 98, 99, 100, 104, 105, 108]
        let query = `
            SELECT c.*, h.nom_hotel, h.categorie 
            FROM chambre c
            JOIN hotel h ON c.id_hotel = h.id_hotel
            WHERE c.capacite = $1 
            AND h.categorie = $2 
            AND c.prix BETWEEN $3 AND $4
        `;
        
        const values = [capacite, categorie, prixMin || 0, prixMax || 9999];
        const result = await pool.query(query, values);
        
        res.render('resultats', { chambres: result.rows });
    } catch (err) {
        console.error(err);
        res.status(500).send("Erreur serveur");
    }
});

app.listen(port, () => {
    console.log(`🚀 Demo ready at http://localhost:${port}`);
});