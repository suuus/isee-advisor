# Governed production deployment

This synthetic fixture demonstrates a complete machine-readable ISEE chain for
a production deployment:

- ratified ADRP Intent requires a blocking security gate;
- effective ASRP Structure binds to that exact Intent fingerprint;
- an ISEE execution manifest selects the production entry point and requires
  `SECURITY-GATE-RESULT`;
- execution metadata retains the manifest, Intent, and Structure fingerprints;
- AERP Evidence is bound to the exact Intent and Structure and includes a
  verified security report;
- the saved ISEE evaluation confirms that all required Evidence is satisfied.

The files are synthetic test data, not operational policy.
