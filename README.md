# Cloudflare Networking

Practical notes, configurations, commands, and experiments for Cloudflare, DNS, proxying, TLS, edge networking, and web infrastructure.

## Scope

This repository focuses on understanding and operating Cloudflare as part of a real infrastructure stack:

- DNS records and delegation
- DNS-only vs proxied traffic
- Cloudflare proxy architecture
- TLS/SSL modes and certificate flows
- HTTP/HTTPS behavior
- Origin-server protection
- Reverse-proxy patterns
- HTTP headers and client IP handling
- Caching concepts
- Firewall and rate-limiting concepts
- Tunnels and private-origin connectivity
- Load balancing concepts
- Troubleshooting DNS and proxy problems
- Cloudflare API automation

The goal is practical infrastructure engineering, not a collection of random settings.

## Architecture

A common deployment pattern is:

```text
Client
  |
  v
DNS
  |
  v
Cloudflare Edge
  |
  +--> TLS termination / security / caching
  |
  v
Origin Firewall
  |
  v
Reverse Proxy
  |
  v
Application
  |
  v
Database / Storage
```

Not every application needs every layer. The correct design depends on traffic, security requirements, application behavior, and operational constraints.

## DNS

Useful records include:

- A
- AAAA
- CNAME
- MX
- TXT

Always verify:

```text
hostname -> DNS answer -> proxy state -> edge response -> origin response
```

Example:

```bash
dig example.com
dig +short example.com
dig +short AAAA example.com
dig CNAME www.example.com
```

For HTTP testing:

```bash
curl -I https://example.com
curl -v https://example.com
```

## Proxying

Cloudflare proxying changes the network path.

DNS-only:

```text
Client -> DNS -> Origin
```

Proxied:

```text
Client -> DNS -> Cloudflare Edge -> Origin
```

This difference matters when diagnosing:

- TLS certificates
- source IP visibility
- firewall rules
- HTTP status codes
- redirects
- caching
- WebSocket behavior
- application allowlists

## TLS

Understand the relationship between:

- browser-to-Cloudflare encryption
- Cloudflare-to-origin encryption
- origin certificates
- public certificates
- certificate validation
- HTTP to HTTPS redirects

Do not treat an HTTPS browser connection as proof that the origin connection is correctly secured.

## Origin Protection

If a service is intended to be accessed through Cloudflare, the origin firewall should be designed accordingly.

Before changing firewall rules:

1. Confirm DNS state.
2. Confirm the actual origin address.
3. Identify required ports.
4. Confirm health-check or management access.
5. Test from an allowed path.
6. Keep a rollback path.

Avoid blindly blocking IP ranges or copying firewall rules from unrelated deployments.

## Useful Commands

### DNS

```bash
dig example.com
dig +trace example.com
nslookup example.com
```

### Connectivity

```bash
curl -I https://example.com
curl -v https://example.com
nc -vz example.com 443
```

### TLS

```bash
openssl s_client -connect example.com:443 -servername example.com
```

### Routing

```bash
ip addr
ip route
ss -lntup
```

## API Automation

Cloudflare can be automated through APIs. Keep credentials outside Git:

```bash
export CLOUDFLARE_API_TOKEN='...'
```

Never commit tokens:

```text
.env
*.key
*.pem
secrets/
credentials/
```

Use environment variables, a secret manager, or the deployment platform's secret store.

## Troubleshooting Method

Use:

```text
DNS
 -> Edge
 -> TLS
 -> HTTP
 -> Firewall
 -> Origin
 -> Application
```

Check one layer at a time.

A useful rule is:

> Change one thing, then verify one thing.

## Research and Reimplementation

This LABS repository may study public Cloudflare-related projects, documentation, configurations, and community implementations.

The workflow is:

```text
Find
  -> Inspect
  -> Understand
  -> Document
  -> Reimplement
  -> Test
  -> Improve
```

Public code should not be copied wholesale into this repository. Reuse is performed only where the applicable license permits it, with required attribution and license notices preserved.

## Related MULTEXPK LABS

This repository fits alongside:

- `linux-vps-engine`
- `vps-automation`
- `cloud-infrastructure`
- `server-troubleshooting`
- `vps-provisioning`
- `infrastructure-research`

## About

Maintained by **Zain Ul Abddin**, Founder of **MULTEXPK LTD ®™**.

MULTEXPK works with secure cloud infrastructure, VPS hosting, automation, SaaS systems, and related engineering services.

For commercial infrastructure and VPS services:

**MULTEXPK LTD ®™ — Secure Cloud • VPS • Hosting • Automation**

https://webvpsserver.com

WhatsApp: +92 312 6565434

## Safety

Examples are intentionally generic. Do not publish:

- API tokens
- private keys
- customer information
- production IP inventories
- database credentials
- session data
- internal firewall policies
- access credentials

Always test infrastructure changes before applying them to production.

© MULTEXPK LTD ®™
