# ADR 0001: Use Fastify Over Express

**Status:** Accepted  
**Date:** 2024-01-15  
**Deciders:** Core Payments squad + Platform squad

## Context

Our API layer needs to handle 5k req/s with p99 < 200ms. Express was our default but profiling showed significant overhead in middleware chain execution. We evaluated Fastify, Hapi, and staying on Express.

## Decision

Use Fastify for all new route handlers. Existing Express routes will be migrated progressively.

## Consequences

**Positive:**
- 2x throughput in benchmarks at our payload sizes
- Built-in schema validation reduces boilerplate
- Plugin system is more structured than Express middleware

**Negative:**
- Team needs to learn Fastify idioms (1-2 weeks ramp-up)
- Some Express middleware incompatible — need to port manually

## Alternatives considered

- **Hapi:** More opinionated, mature, but slower than Fastify and declining npm trend
- **Stay on Express:** Predictable but doesn't meet our latency target
