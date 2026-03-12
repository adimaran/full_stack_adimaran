# Full-Stack Repository Plan

This document provides an execution plan to take this repository from local development to production deployment.

## 1) Foundation (Day 1)
- Confirm stack choices:
  - `apps/web`: React + Vite
  - `apps/api`: Express + TypeScript
  - Data/auth: Supabase
- Configure local environment files:
  - `apps/api/.env`
  - `apps/web/.env.local`
- Initialize Supabase schema from `apps/api/supabase/schema.sql`.

Exit criteria:
- `npm run dev` boots web + API.
- `GET /health` returns `{"status":"ok"}`.

## 2) Core Product Scope (Days 2-4)
- Authentication
  - Sign up
  - Login
  - Role assignment (`member` default, promote selected users to `admin`)
- Admin capabilities
  - Create class
  - List all classes
- Member capabilities
  - Browse classes
  - Register for a class

Exit criteria:
- End-to-end happy path tested for both roles.

## 3) Quality & Readiness (Day 5)
- Add checks to CI (recommended):
  - install dependencies
  - build API + web
- Add environment validation for required variables.
- Review CORS configuration for production web URL.

Exit criteria:
- Builds pass in CI.
- Production env vars documented and validated.

## 4) Deployment (Day 6)
- Deploy API on Render using `render.yaml`.
- Deploy web on Vercel using `apps/web/vercel.json`.
- Configure env vars:
  - API: `SUPABASE_URL`, `SUPABASE_PUBLISHABLE_KEY`, `SUPABASE_SERVICE_ROLE_KEY`, `CORS_ORIGINS`
  - Web: `VITE_API_BASE_URL`

Exit criteria:
- Health check endpoint is green.
- Login and class registration works in production.

## 5) Post-Launch Enhancements
- Add observability (request logs, error tracking).
- Add E2E tests (Playwright/Cypress).
- Add CI/CD deployment protection rules and preview workflows.
- Add seed script/demo data for quick staging validation.
