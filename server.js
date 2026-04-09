const express = require('express');
const { Pool } = require('pg');
require('dotenv').config();

const app = express();
const port = 3000;
const MOCK_MODE = true; 

const pool = new Pool({
  user: process.env.DB_USER, host: process.env.DB_HOST,
  database: process.env.DB_DATABASE, password: process.env.DB_PASSWORD, port: process.env.DB_PORT,
});

app.set('view engine', 'ejs');
app.use(express.static('public'));
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => res.render('recherche'));

app.get('/rechercher', async (req, res) => {
    const { capacite, categorie, prixMin, prixMax, superficie, dateDebut, dateFin } = req.query;
    if (MOCK_MODE) {
        const mock = [{ id_chambre: 101, nom_hotel: "Ottawa Grand", categorie: 5, prix: 200, capacite: "double", superficie: 45, vue: "Parc", commodites: "WiFi, TV" }];
        return res.render('resultats', { chambres: mock, dateDebut, dateFin });
    }
});

app.get('/employe', (req, res) => {
    const mockRes = [{ id: 501, client: "Dirir Ahmed", chambre: 101, dates: "Apr 8-12" }];
    res.render('employe', { reservations: mockRes });
});

app.get('/admin', (req, res) => res.render('admin'));

app.get('/stats', (req, res) => {
    const mockViews = { zone: "Ottawa-Centre", dispo: 24, hotel: "Ottawa Grand", capacite: 150 };
    res.render('stats', { views: mockViews });
});

app.post('/reserver', (req, res) => {
    res.send('<body style="background:#121416;color:white;text-align:center;padding-top:50px;"><h1>Succès!</h1><p>La chambre a été réservée.</p><a href="/" style="color:#0dcaf0;">Retour</a></body>');
});

app.listen(port, () => console.log(`🚀 v3.2 ready at http://localhost:${port}`));