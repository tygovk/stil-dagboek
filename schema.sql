-- Stil: versleutelde dagboekkluis per Supabase-gebruiker.
-- Eenmalig uitvoeren in de SQL Editor van je eigen Supabase-project.
begin;
create table if not exists public.stil_vaults (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload text not null check (octet_length(payload) <= 10000000),
  revision bigint not null default 1 check (revision > 0),
  updated_at timestamptz not null default now()
);
alter table public.stil_vaults enable row level security;
revoke all on public.stil_vaults from anon;
revoke all on public.stil_vaults from authenticated;
grant select, insert, update on public.stil_vaults to authenticated;
drop policy if exists stil_read_own on public.stil_vaults;
create policy stil_read_own on public.stil_vaults for select to authenticated
  using ((select auth.uid()) = user_id);
drop policy if exists stil_insert_own on public.stil_vaults;
create policy stil_insert_own on public.stil_vaults for insert to authenticated
  with check ((select auth.uid()) = user_id);
drop policy if exists stil_update_own on public.stil_vaults;
create policy stil_update_own on public.stil_vaults for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
-- Optimistische vergrendeling: een verouderd apparaat overschrijft geen nieuwe versie.
create or replace function public.stil_save_vault(p_payload text, p_expected_revision bigint)
returns bigint language plpgsql security invoker set search_path = '' as $$
declare next_revision bigint;
begin
  if auth.uid() is null then
    raise exception 'Inloggen vereist' using errcode = '42501';
  end if;
  if p_expected_revision = 0 then
    insert into public.stil_vaults (user_id, payload)
      values (auth.uid(), p_payload)
      on conflict (user_id) do nothing
      returning revision into next_revision;
  else
    update public.stil_vaults
      set payload = p_payload, revision = revision + 1, updated_at = now()
      where user_id = auth.uid() and revision = p_expected_revision
      returning revision into next_revision;
  end if;
  if next_revision is null then
    raise exception 'Dit dagboek is op een ander apparaat gewijzigd. Laad de nieuwste versie.' using errcode = '40001';
  end if;
  return next_revision;
end;
$$;
revoke all on function public.stil_save_vault(text,bigint) from public, anon;
grant execute on function public.stil_save_vault(text,bigint) to authenticated;
commit;
