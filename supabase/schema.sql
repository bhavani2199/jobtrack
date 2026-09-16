-- jobtrack — Supabase schema
-- Column names match JobApplication.toJson()/fromJson() exactly.
-- Run this in your Supabase project's SQL editor (Dashboard -> SQL Editor -> New query).

-- Topic 1: primary key. id is unique per row, generated automatically.
-- Topic 3: data types & constraints. status is restricted to the same 4
-- values your DropdownButtonFormField already offers.

create table applications (
  id uuid primary key default gen_random_uuid(),
  company_name text not null,
  role_title text not null,
  status text not null default 'Applied'
    check (status in ('Applied', 'Interviewing', 'Offer', 'Rejected')),
  applied_date date not null,
  created_at timestamp default now()
);

-- Topic 2: foreign key. Each round belongs to exactly one application.
-- on delete cascade: deleting an application deletes its rounds too —
-- otherwise you'd get rounds pointing at nothing.

create table interview_rounds (
  id uuid primary key default gen_random_uuid(),
  application_id uuid references applications(id) on delete cascade,
  round_name text not null,
  round_date date,
  outcome text
);

-- Topic 7 (later): index so filtering/sorting by status and date is fast
-- instead of scanning every row.
create index idx_applications_status on applications(status);
create index idx_applications_applied_date on applications(applied_date);
