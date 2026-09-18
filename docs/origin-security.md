# Origin Security

Cloudflare is not a substitute for origin security.

## Principles

- Expose only required ports.
- Keep management services restricted.
- Use least privilege.
- Separate public and administrative traffic.
- Monitor rejected connections.
- Maintain an emergency access path.
- Document firewall changes.

## Before Restricting Origin Access

Verify:

```text
DNS
 -> Cloudflare proxy
 -> Origin port
 -> Firewall
 -> Application
```

A firewall change made before confirming this chain can accidentally lock out the application or administrators.

## Example Inspection

```bash
ss -lntup
ip route
sudo ufw status verbose
```

On systems using another firewall framework, inspect the active framework instead of assuming UFW is installed.

## Secrets

Never place API tokens or private keys in firewall scripts committed to Git.

Use environment variables or a secret manager.
