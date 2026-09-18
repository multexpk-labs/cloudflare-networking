# Proxying and TLS

Cloudflare can sit between a client and an origin server.

## Two Connections

With a proxied HTTPS application there are normally two relevant connections:

```text
Browser
   |
   | HTTPS
   v
Cloudflare
   |
   | HTTP or HTTPS
   v
Origin
```

These connections have separate TLS considerations.

## TLS Modes

The important distinction is whether Cloudflare encrypts traffic to the origin and whether the origin certificate is validated.

For production systems, understand the behavior of the selected mode before changing it.

## Diagnostics

Inspect the certificate:

```bash
openssl s_client -connect example.com:443 -servername example.com
```

Inspect HTTP headers:

```bash
curl -I https://example.com
```

Verbose request:

```bash
curl -vk https://example.com
```

Do not use insecure TLS options as a permanent production fix. They are diagnostic tools.

## Common Symptoms

### Redirect loop

Check:

- browser HTTPS state
- Cloudflare TLS mode
- origin HTTP/HTTPS behavior
- application canonical URL
- redirect rules

### 525/526-style origin TLS failures

Check:

- origin listener
- certificate
- certificate hostname
- TLS protocol compatibility
- firewall
- Cloudflare-to-origin reachability
