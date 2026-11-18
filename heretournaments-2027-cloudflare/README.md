# heretournaments — ny version

En ren, statisk hemsida för Cloudflare Pages. Inga adminkonton, formulär, databaser eller Supabase-nycklar behövs.

## Publicera via GitHub och Cloudflare Pages

1. Ta bort de gamla filerna `index.html`, `config.js`, `schema.sql` och eventuella gamla scripts som inte används i ditt GitHub-repository.
2. Lägg dessa fyra filer i repositoryts rot (inte inuti en extra mapp): `index.html`, `countdown.html`, `styles.css`, `countdown.js`.
3. Commit ändringarna. Cloudflare Pages ska automatiskt publicera den nya versionen om GitHub-repositoryt redan är kopplat.
4. Kontrollera https://heretournaments.pages.dev/ och https://heretournaments.pages.dev/countdown.html.
5. Om du ser en gammal version, vänta tills den nya Cloudflare-deployen är klar och uppdatera sidan.

## Innehåll

- Startsida med information om Here Open
- Laganmälan via https://discord.gg/fDxVBphqWV
- Kontakt via kontaktkontaktnils@gmail.com
- Separat nedräkningssida till 15 maj 2027 kl 00:00 svensk tid (CEST)

Ingen data från besökare samlas in av hemsidan. Discord och mejl hanteras av respektive tjänst.
