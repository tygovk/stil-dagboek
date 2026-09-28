# Stil met één wachtwoord

## Inloggen

1. Bewaar je tekst en vernieuw dagboek.html.
2. Kies **Open via Supabase**.
3. Vul je e-mailadres en je bestaande **Supabase-appaccountwachtwoord** in. Dit is niet je Supabase-dashboardwachtwoord.
4. Klik op **Open dagboek**.

Als je bestaande dagboek nog met een ander wachtwoord versleuteld is, verschijnt eenmalig **Oud dagboekwachtwoord**. Vul dat in en klik opnieuw op **Open dagboek**. De app versleutelt je berichten en OpenAI-key opnieuw met je accountwachtwoord. Vanaf dan gebruik je op ieder apparaat alleen je e-mailadres en dat ene wachtwoord.

Bij een verkeerd oud wachtwoord wordt niets gewijzigd. Je lokale exemplaar blijft behouden.

## Nieuwe accounts en import

Maak een account met e-mail en wachtwoord via **Account maken**, of gebruik een bestaande gebruiker binnen dit Supabase-project. Bevestig zo nodig je e-mail.

Importeer een lokaal dagboek alleen bij een nieuw, leeg cloudaccount via **Mijn bestaande lokale dagboek meenemen**. Als het lokale wachtwoord afwijkt, wordt het eenmalig gevraagd. Vervolgens wordt de nieuwe cloudkluis met het accountwachtwoord beveiligd.

## Wachtwoord wijzigen

Gebruik **Wachtwoord wijzigen** in de dagboek-app. In cloudmodus worden zowel het Supabase-accountwachtwoord als de versleuteling bijgewerkt. Tijdens deze wijziging bewaart de app tijdelijk twee versleutelde versies, zodat een onderbroken verbinding je niet buitensluit. Als de app vraagt opnieuw in te loggen, volg die melding om de wijziging af te ronden.

Een wachtwoordreset via Supabase buiten deze app ontsleutelt de bestaande kluis niet: daarvoor blijft het oude wachtwoord nodig. Bewaar je wachtwoord goed.

## Opslag

De cloudkluis staat versleuteld in `public.stil_vaults`. Berichten en de OpenAI-key zijn alleen na ontsleuteling leesbaar. Gebruik **Verversen** voor wijzigingen vanaf andere apparaten. Bij gelijktijdige wijzigingen voorkomt een versiecontrole dat je een nieuwere kluis overschrijft.

Het bestaande supabase-schema.sql blijft geldig; voor één wachtwoord is geen nieuwe SQL-migratie nodig.

## Validatie

Getest met gesimuleerde API-antwoorden: eenmalige migratie, onjuist oud wachtwoord, opnieuw inloggen met één wachtwoord, behoud van berichten en API-key, cloudopslag, import, versieconflicten, sessievernieuwing, wachtwoordwijziging en herstel na een geweigerde accountwijziging. De omzetting in je echte project gebeurt pas wanneer je zelf inlogt.
