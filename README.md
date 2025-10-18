# Enphase OpenAPI Spec

This repository tracks an **unofficial** OpenAPI 3 definition for the Enphase v4 Monitoring API and provides a script to regenerate the spec from Enphase’s published swagger document. For official documentation, refer to the [Enphase API v4 portal](https://developer-v4.enphase.com/docs.html).

## Contents

- `openapi/system.yaml` – OpenAPI 3.0 representation of the Monitoring (System) API.
- `scripts/convert_system_spec.sh` – Helper script that downloads the latest swagger (`System_API.json`) from the Enphase developer portal and converts it to OpenAPI 3 using `swagger2openapi` via `npx`.

## Requirements

- Node.js 18+ (includes npm)
- curl

These are required at runtime by the conversion script. No Python or local swagger JSON is needed because the script fetches the source spec on demand.

## Authentication

According to Enphase’s guides, each Monitoring API request must include:

- An OAuth 2.0 access token in the `Authorization: Bearer <token>` header.
- Your application API key in the `key` header.

The OpenAPI definition models both requirements via the `oauth2` bearer scheme and `apiKey` header security scheme.

Tooling for validation is pinned via `package.json` (currently `@redocly/cli@2.7.0`) so that local executions and CI use the same version.

## Regenerating the Spec

Run:

```bash
./scripts/convert_system_spec.sh
```

The script will:

1. Download `https://developer-v4.enphase.com/swagger/spec/System_API.json` into a temporary directory.
2. Execute `npx --yes swagger2openapi` to convert the swagger 2.0 document into OpenAPI 3.0 YAML.
3. Overwrite `openapi/system.yaml` with the generated output.

> Note: `npx` automatically installs and caches the `swagger2openapi` package per run; the CLI uses your local Node/npm environment and does not require Docker.

## Validating

You can lint the definition locally with:

```bash
npm install
npm run lint:openapi
```

Pull requests automatically run the same lint check via the `OpenAPI Lint` GitHub Action.

## Next Steps

- Integrate automated validation/linting (e.g., GitHub Action).
- Add examples for using `openapi-generator-cli` if code generation is desired.
- Document authentication requirements for the Monitoring API once finalized.
