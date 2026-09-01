# Kibana Exports

After building your dashboard in Kibana (Analytics → Dashboard), export it here:

1. Kibana → **Stack Management → Saved Objects**
2. Select your dashboard, its visualizations, and the `siem-auth-*` index pattern
3. Click **Export** → save the `.ndjson` file into this folder as `siem-dashboard.ndjson`

Anyone cloning this repo can then re-import it:

Kibana → **Stack Management → Saved Objects → Import** → select `siem-dashboard.ndjson`
