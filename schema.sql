-- kör hela filen i supabase SQL editor
create table if not exists public.admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade
);
create table if not exists public.applications (
  id uuid primary key default gen_random_uuid(),
  team text not null check (char_length(trim(team)) between 1 and 60),
  captain text not null check (char_length(trim(captain)) between 1 and 60),
  email text not null check (char_length(trim(email)) between 3 and 200),
  status text not null default 'väntar' check (status in ('väntar','godkänd','nekad')),
  created_at timestamptz not null default now()
);
create table if not exists public.matches (
  id uuid primary key default gen_random_uuid(),
  team1 text not null check (char_length(trim(team1)) between 1 and 60),
  team2 text not null check (char_length(trim(team2)) between 1 and 60),
  scheduled_at timestamptz not null,
  status text not null default 'kommande' check (status in ('kommande','pågår','avslutad')),
  created_at timestamptz not null default now()
);
create table if not exists public.results (
  id uuid primary key default gen_random_uuid(),
  team1 text not null check (char_length(trim(team1)) between 1 and 60),
  team2 text not null check (char_length(trim(team2)) between 1 and 60),
  score1 integer not null check (score1 between 0 and 999),
  score2 integer not null check (score2 between 0 and 999),
  created_at timestamptz not null default now()
);
alter table public.admin_users enable row level security;
alter table public.applications enable row level security;
alter table public.matches enable row level security;
alter table public.results enable row level security;
-- låt en användare kontrollera sin egen adminstatus, men aldrig lägga till sig själv
create policy "read own admin membership" on public.admin_users for select to authenticated using (user_id = (select auth.uid()));
-- admin-kontroll via säker funktion som inte kan ändras av vanliga besökare
create or replace function public.is_here_admin() returns boolean language sql stable security definer set search_path = '' as $$
  select exists (select 1 from public.admin_users where user_id = (select auth.uid()));
$$;
revoke all on function public.is_here_admin() from public;
grant execute on function public.is_here_admin() to authenticated;
create policy "submit applications" on public.applications for insert to anon, authenticated with check (status = 'väntar');
create policy "admins read applications" on public.applications for select to authenticated using ((select public.is_here_admin()));
create policy "admins update applications" on public.applications for update to authenticated using ((select public.is_here_admin())) with check ((select public.is_here_admin()));
create policy "admins delete applications" on public.applications for delete to authenticated using ((select public.is_here_admin()));
create policy "public read matches" on public.matches for select to anon, authenticated using (true);
create policy "admins add matches" on public.matches for insert to authenticated with check ((select public.is_here_admin()));
create policy "admins update matches" on public.matches for update to authenticated using ((select public.is_here_admin())) with check ((select public.is_here_admin()));
create policy "admins delete matches" on public.matches for delete to authenticated using ((select public.is_here_admin()));
create policy "public read results" on public.results for select to anon, authenticated using (true);
create policy "admins add results" on public.results for insert to authenticated with check ((select public.is_here_admin()));
create policy "admins update results" on public.results for update to authenticated using ((select public.is_here_admin())) with check ((select public.is_here_admin()));
create policy "admins delete results" on public.results for delete to authenticated using ((select public.is_here_admin()));
-- lägg till ditt eget användar-id EFTER att du skapat kontot i supabase authentication
-- ersätt värdet och kör kommandot separat:
-- insert into public.admin_users(user_id) values ('DITT-USER-UUID');
