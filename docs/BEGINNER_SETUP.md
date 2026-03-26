# Beginner Setup Guide (Supabase + Local + Deploy)

This guide assumes very little coding experience and gives copy-paste steps.

---

## What you need first
- A **Supabase account**: https://supabase.com
- A **GitHub account** (for deployment to Render/Vercel)
- **Node.js 20+** installed: https://nodejs.org
- **VS Code** installed: https://code.visualstudio.com

---

## 1) Create your Supabase project

1. Go to Supabase Dashboard.
2. Click **New project**.
3. Choose organization.
4. Set:
   - **Project name**: anything (example: `community-classes-app`)
   - **Database password**: create and save this in a password manager
   - **Region**: closest to your users
5. Click **Create new project** and wait until it finishes.

---

## 2) Get Supabase keys and URL

In Supabase dashboard:
1. Open your project.
2. Go to **Project Settings → API**.
3. Copy these values:
   - **Project URL**
   - **anon/public key** (safe for frontend usage)
   - **service_role key** (backend only, keep secret)

### Important key rules
- `anon/public` key can be used in browser apps.
- `service_role` key is **secret** and must stay on backend/server only.
- Do not paste `service_role` into frontend files.

You do **not** need to change anything in API key settings for this starter app.
Just copy the generated keys and use them in environment files.

---

## 3) Open project in VS Code

In terminal (Git Bash / macOS / Linux):

```bash
git clone <YOUR_REPOSITORY_URL>
cd full_stack_adimaran
code .
```

If `code .` does not work, open VS Code manually and choose **File → Open Folder**.

---

## 4) Bootstrap project files and dependencies

From project root:

```bash
npm run setup
```

This will:
- install dependencies
- create `apps/api/.env` if missing
- create `apps/web/.env.local` if missing

---

## 5) Put your Supabase values into env files

### 5A) Backend env file (`apps/api/.env`)

Open `apps/api/.env` in VS Code and replace placeholders:

```env
SUPABASE_URL="https://YOUR-PROJECT-ID.supabase.co"
SUPABASE_PUBLISHABLE_KEY="YOUR_ANON_PUBLIC_KEY"
SUPABASE_SERVICE_ROLE_KEY="YOUR_SERVICE_ROLE_KEY"
CORS_ORIGINS="http://localhost:5173"
PORT=4000
```

### 5B) Frontend env file (`apps/web/.env.local`)

```env
VITE_API_BASE_URL="http://localhost:4000"
```

---

## 6) Create database tables in Supabase

1. In Supabase dashboard, go to **SQL Editor**.
2. Click **New query**.
3. Open local file `apps/api/supabase/schema.sql` in VS Code.
4. Copy all SQL from that file.
5. Paste into Supabase SQL Editor.
6. Click **Run**.

After this, tables like `users`, `community_classes`, and `class_registrations` should exist.

---

## 7) Start app locally

In terminal at repo root:

```bash
npm run dev
```

Open:
- Web: http://localhost:5173
- API health: http://localhost:4000/health

You should see:

```json
{"status":"ok"}
```

---

## 8) Common first-time checks (copy-paste)

Run build check:

```bash
npm run check
```

If needed, reinstall dependencies:

```bash
npm install
```

---

## 9) Deploy checklist (Render API + Vercel Web)

### Render (API)
Set these env vars in Render service:

```text
SUPABASE_URL
SUPABASE_PUBLISHABLE_KEY
SUPABASE_SERVICE_ROLE_KEY
CORS_ORIGINS=https://YOUR-VERCEL-DOMAIN.vercel.app,http://localhost:5173
```

### Vercel (Web)
Set this env var in Vercel project:

```text
VITE_API_BASE_URL=https://YOUR-RENDER-API.onrender.com
```

No trailing slash at the end of URL.

---

## 10) Quick troubleshooting

- **CORS error in browser:** make sure `CORS_ORIGINS` exactly includes your Vercel domain.
- **401/403 errors:** check you copied correct Supabase keys into `apps/api/.env`.
- **Frontend cannot call API:** verify `VITE_API_BASE_URL` points to running API URL.
- **Key safety:** if you accidentally exposed `service_role`, rotate it in Supabase API settings.
