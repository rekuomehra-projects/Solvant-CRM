#!/usr/bin/env bash
set -euo pipefail

SITE_NAME="${SITE_NAME:-solvant.localhost}"
ADMIN_PASSWORD="${ADMIN_PASSWORD:-admin}"
DB_ROOT_PASSWORD="${DB_ROOT_PASSWORD:-admin}"

echo "Bootstrapping Solvant Frappe stack for ${SITE_NAME}"

# Run this from an existing Frappe Bench using Frappe v15.
# CRM is installed from this Solvant fork's stable branch.
if [ ! -d "apps/crm" ]; then
  bench get-app --branch solvant/stable-main crm https://github.com/rekuomehra-projects/Solvant-CRM.git
fi

if [ ! -d "apps/erpnext" ]; then
  bench get-app --branch version-15 erpnext https://github.com/frappe/erpnext.git
fi

if [ ! -d "apps/hrms" ]; then
  bench get-app --branch version-15 hrms https://github.com/frappe/hrms.git
fi

if [ ! -d "sites/${SITE_NAME}" ]; then
  bench new-site "${SITE_NAME}"     --admin-password "${ADMIN_PASSWORD}"     --mariadb-root-password "${DB_ROOT_PASSWORD}"
fi

bench --site "${SITE_NAME}" install-app erpnext || true
bench --site "${SITE_NAME}" install-app hrms || true
bench --site "${SITE_NAME}" install-app crm || true

bench --site "${SITE_NAME}" migrate
bench --site "${SITE_NAME}" clear-cache

echo
echo "Installed stack:"
bench --site "${SITE_NAME}" list-apps
echo
echo "Start with: bench start"
echo "CRM URL: http://${SITE_NAME}:8000/crm"
