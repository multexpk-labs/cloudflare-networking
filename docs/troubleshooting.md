# Cloudflare Troubleshooting

Use evidence before changing configuration.

## Step 1 — DNS

```bash
dig +short example.com
dig +short AAAA example.com
```

Confirm the expected record and proxy state.

## Step 2 — HTTPS

```bash
curl -I https://example.com
curl -v https://example.com
```

Record the status code, redirects, and relevant headers.

## Step 3 — Origin

From an authorized management environment:

```bash
curl -I http://ORIGIN_HOSTNAME
curl -I https://ORIGIN_HOSTNAME
```

Do not expose private origin addresses in public documentation.

## Step 4 — Listening Services

```bash
ss -lntup
```

Confirm that the expected service is actually listening.

## Step 5 — Logs

Inspect the reverse proxy, web server, firewall, and application logs around the exact request time.

## Method

```text
Observe
Measure
Narrow down
Test
Change
Verify
Document
```

Avoid changing multiple unrelated settings at once.
