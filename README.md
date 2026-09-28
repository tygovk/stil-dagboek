# Stil — persoonlijk dagboek

Responsive Nederlandstalige dagboek-app in één HTML-bestand, met lokale opslag, optionele Supabase-opslag en AI-quotes via OpenAI.

## Openen

Open `index.html` in een recente browser. Er zijn geen installatie- of buildstappen.

De app bevat:
- een datumkiezer, editor en chronologische historie;
- bewerken en verwijderen van berichten;
- ingebouwde quotes en optionele OpenAI-quotes;
- AES-GCM-versleuteling, met een sleutel afgeleid van je wachtwoord via PBKDF2;
- cloudinloggen via Supabase en import van een lokaal dagboek;
- versiecontrole die conflicten tussen apparaten meldt.

## Supabase

Het bestaande Supabase-project is al ingesteld in `index.html` via `SUPABASE_URL` en `SUPABASE_PUBLISHABLE_KEY`. Deze publishable key is bedoeld voor de browser; databasetoegang wordt afgedwongen met Supabase Auth en Row Level Security.

Voor een ander Supabase-project:
1. Wijzig die twee waarden in `index.html`.
2. Voer `supabase/schema.sql` uit in de SQL Editor van dat project.
3. Maak een appgebruiker en configureer indien nodig e-mailbezorging.

Gebruik nooit een secret key of service_role-key in dit bestand of deze repository.

Zie `HANDLEIDING.md` voor inloggen, versleuteling en import. Waar die handleiding `dagboek.html` noemt, gebruik je in dit project `index.html`. Het SQL-bestand staat hier onder `supabase/schema.sql`.

## OpenAI

Voer je eigen OpenAI API-key in via **AI instellen**. De key wordt samen met je dagboek versleuteld opgeslagen, niet in de HTML-broncode. De app verstuurt alleen quoteopdrachten en recente quotes naar OpenAI.

Deze app is bedoeld voor persoonlijk gebruik: tijdens een ontgrendelde sessie is de API-key via de browser toegankelijk. Voor een publieke app met een gedeelde API-key is een serverfunctie nodig.

## Wat staat er op GitHub?

Alleen broncode, SQL en instructies. Je dagboekberichten, wachtwoorden, sessies en persoonlijk ingevoerde OpenAI-key staan niet in deze repository. GitHub synchroniseert code; Supabase bewaart je versleutelde dagboek.

## Nieuwe GitHub-repository

1. Open https://github.com/new en log in.
2. Kies bijvoorbeeld `stil-dagboek` als naam en **Private** als zichtbaarheid.
3. Laat de opties om een README, .gitignore of licentie toe te voegen uit; deze map bevat al een README en .gitignore.
4. Klik **Create repository**.
5. Kies **uploading an existing file**. Upload de inhoud van deze map: `index.html`, `README.md`, `HANDLEIDING.md`, `.gitignore` en de map `supabase`.
6. Klik **Commit changes**.

Upload de uitgepakte bestanden, niet alleen het zipbestand. Er wordt hiermee geen website gepubliceerd.

### Koppelen met Git

Deze map kan ook via Git worden gekoppeld. Vervang `JOUW-NAAM` door je GitHub-gebruikersnaam:

```sh
git add .
git commit -m "Voeg Stil dagboek toe"
git remote add origin https://github.com/JOUW-NAAM/stil-dagboek.git
git push -u origin main
```

Git kan om je GitHub-inlog vragen. Als Git nog geen auteursnaam en e-mailadres kent, stel die eerst in voor deze repository.

## Bestaande lokale gegevens

Het openen vanaf een andere bestandslocatie of website kan een andere browseropslag gebruiken. Importeer lokale berichten daarom eerst via het oorspronkelijke dagboekbestand naar Supabase. Open daarna deze versie via **Open via Supabase** met hetzelfde account. Een kopie van de HTML bevat op zichzelf geen lokale berichten.

## Validatie

De app is eerder getest met gesimuleerde API-antwoorden voor opslag, migratie, wachtwoordwijzigingen en conflicten. De GitHub-versie gebruikt dezelfde appcode. Test toegang en opslag in je eigen Supabase-project voordat je erop vertrouwt.
