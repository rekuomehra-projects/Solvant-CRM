# Solvant CRM Platform Architecture

## Purpose

This repository is the Solvant-controlled fork of Frappe CRM. We keep Frappe CRM core close to upstream and put customer-specific functionality in a separate Solvant custom app rather than modifying upstream core wherever possible.

## Stable baseline

Do **not** build client work from the upstream `develop` branch. Frappe documents it as the future/unstable v2/v17 line.

Our stable CRM baseline is:

- Solvant CRM: `solvant/stable-main` (derived from upstream Frappe CRM `main`)
- Frappe Framework: v15
- ERPNext: `version-15`
- Frappe HR / HRMS: `version-15`

## Target application stack

1. **Frappe CRM**
   - Leads
   - Deals
   - Contacts
   - Activities
   - Email
   - Telephony integration

2. **ERPNext**
   - Products/services
   - Quotations
   - Sales invoices
   - Payments
   - Accounting
   - Financial reporting

3. **Frappe HR**
   - Employee records
   - Recruitment
   - Leave
   - Attendance
   - Performance
   - Payroll where applicable

4. **Solvant custom app** (next repository/app to create)
   - My Day homepage
   - Appointment Setter workspace
   - Sales Agent workspace
   - Client Operations / Client Case
   - Mandatory stage documents
   - Renewals
   - Commission engine
   - AI call summaries
   - AI task extraction
   - AI quotation drafting
   - LeadConnector/Twilio adapter
   - Management KPI dashboards
   - Customer-specific branding

## Design rule

Avoid client-specific edits to Frappe CRM, ERPNext, or HRMS core unless there is no extension point available. Prefer hooks, custom DocTypes, overrides, workflows, custom pages, and integration services in the Solvant app.

## First proof-of-concept flow

Lead
→ Call
→ Call activity recorded
→ AI summary
→ Appointment
→ Deal
→ Draft quotation
→ Quote accepted
→ Client Case created
→ Required-document stages
→ Invoice
→ Commission
→ Renewal reminder

## Bootstrap

From an existing Frappe Bench v15 installation:

```bash
chmod +x scripts/bootstrap-full-stack.sh
SITE_NAME=solvant.localhost ./scripts/bootstrap-full-stack.sh
```

For production we will deploy on managed Frappe Cloud or a dedicated server; local Bench is for development/testing.
