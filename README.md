
# SIEM Dashboard with the ELK Stack (Kali Linux)

A mini-SIEM built on Kali Linux using **Elasticsearch, Logstash, Kibana, and Filebeat**
(via Docker Compose), visualizing SSH authentication events and detecting brute-force
login attempts.

This project was built as a hands-on cybersecurity lab to practice log ingestion,
parsing, enrichment, and dashboarding — the core workflow behind any real-world SIEM.

## Architecture

```
Filebeat -> Logstash (grok + geoip) -> Elasticsearch -> Kibana
```

See [`docs/architecture.md`](docs/architecture.md) for details.

## Features

- Failed vs. successful SSH login tracking
- Top attacking IP addresses
- Geo map of login attempts (via GeoIP enrichment)
- Auth event timeline dashboard in Kibana


## Prerequisites

- Kali Linux (VM or bare metal), 4 GB+ RAM allocated (6–8 GB recommended)
- Docker + Docker Compose
- `git`

## Setup

```bash
# 1. Fix a common Kali/Elasticsearch limit
sudo sysctl -w vm.max_map_count=262144
echo 'vm.max_map_count=262144' | sudo tee -a /etc/sysctl.conf

# 2. Launch the stack
docker-compose up -d

# 3. Verify
curl http://localhost:9200
```

Install and point Filebeat at the host's auth logs (see `filebeat/filebeat.yml`):

```bash
sudo apt install filebeat -y
sudo cp filebeat/filebeat.yml /etc/filebeat/filebeat.yml
sudo systemctl enable filebeat --now
```

Generate some test data:

```bash
./scripts/simulate_bruteforce.sh 20
```

Open Kibana at **http://localhost:5601**, create an index pattern for `siem-auth-*`,
and build/import the dashboard (see `kibana-exports/README.md`).

## Project Structure

```
siem-elk-project/
├── docker-compose.yml
├── .gitignore
├── README.md
├── logstash/
│   ├── pipeline/logstash.conf
│   └── config/logstash.yml
├── filebeat/filebeat.yml
├── scripts/simulate_bruteforce.sh
├── kibana-exports/         # exported dashboard .ndjson goes here
├── screenshots/            # dashboard screenshots for this README
└── docs/architecture.md
```

## Tech Stack

Kali Linux · Docker · Elasticsearch 8.13 · Logstash 8.13 · Kibana 8.13 · Filebeat




