# DNS Fundamentals

DNS translates names into records used by clients and infrastructure.

## Common Records

| Record | Purpose |
|---|---|
| A | IPv4 address |
| AAAA | IPv6 address |
| CNAME | Alias to another hostname |
| MX | Mail routing |
| TXT | Verification and policy data |
| NS | Authoritative nameservers |

## Inspect Records

```bash
dig example.com
dig +short example.com
dig +short AAAA example.com
dig MX example.com
dig TXT example.com
```

For a specific resolver:

```bash
dig @1.1.1.1 example.com
dig @8.8.8.8 example.com
```

## Troubleshooting

When a hostname does not work, separate:

1. Registrar delegation
2. Authoritative DNS
3. DNS record
4. Resolver cache
5. Cloudflare proxy state
6. TLS
7. Origin connectivity

Do not change DNS repeatedly without first identifying which layer is failing.
