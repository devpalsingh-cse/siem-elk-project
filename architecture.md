# Architecture

```
[Log Sources]          [Shipper]        [Pipeline]                [Storage/UI]
 auth.log, syslog  -->  Filebeat  -->   Logstash (grok + geoip)  --> Elasticsearch
                                                                          |
                                                                          v
                                                                       Kibana
                                                               (Dashboards / Alerts)
```

- **Filebeat** runs on the Kali host and tails `/var/log/auth.log` and `/var/log/syslog`,
  forwarding raw log lines to Logstash over port 5044.
- **Logstash** (in Docker) parses each line with a `grok` filter, tags failed vs.
  successful SSH logins, enriches the source IP with `geoip`, and writes structured
  documents into Elasticsearch under the `siem-auth-*` index pattern.
- **Elasticsearch** (in Docker) stores and indexes the events.
- **Kibana** (in Docker) reads from Elasticsearch and renders the SIEM dashboard:
  failed-login timeline, top attacker IPs, success/failure split, and a geo map.

See the root `README.md` for setup steps and `docs/` for the full project guide PDF.
