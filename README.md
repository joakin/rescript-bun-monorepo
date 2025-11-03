# ReScript Bun Monorepo

A ReScript monorepo using Bun workspaces.

## Structure

```
rescript-bun-monorepo/
├── packages/
│   ├── common/            # Common utilities package
│   └── app/               # Application package
├── package.json           # Root monorepo config
├── rescript.json          # Root ReScript config
└── bun.lockb             # Bun lockfile
```

## Installation

```sh
bun install
```

## Development

### Build all packages

```sh
bun run build
```

### Watch mode (development)

```sh
bun run dev
```

### Clean build artifacts

```sh
bun run clean
```

### Format code

```sh
bun run format
```

## Run Demo

```sh
node packages/app/src/Demo.res.js
```

## Adding New Packages

1. Create a new directory in `packages/your-package-name/`
2. Add a `package.json` with scoped name (e.g., `@rescript-bun-monorepo/your-package-name`)
3. Add a `rescript.json` configuration
4. **Add the new package to root `package.json` dependencies**:
   ```json
   {
     "dependencies": {
       "@rescript-bun-monorepo/your-package-name": "workspace:*"
     }
   }
   1. Run `bun install` to create the necessary symlinks
   ```
5. **Add the new package to root `rescript.json` dependencies**:
   ```json
   {
     "dependencies": ["@rescript-bun-monorepo/your-package-name"]
   }
   ```

### Why This Setup is Required

This monorepo uses **Bun's isolated install mode** (default for monorepos). In this mode:

- **Workspace packages are only symlinked** when they are listed as dependencies
- **ReScript requires packages to be discoverable** via `node_modules`
- **Adding packages to both `package.json` and `rescript.json`** ensures proper symlinks and ReScript discovery

## Package Management

This monorepo uses Bun workspaces with **isolated install mode** for dependency management:

### Basic Commands

- Install dependencies: `bun install`
- Add dependency to specific package: `cd packages/package-name && bun add dependency`
- For dependencies that can be used across packages add them to the top level
  package.json in the catalog so that all packages share the same versions.
- Add dev dependency to root: `bun add -d dependency`
  - Move it to the catalog

### Workspace Dependencies

- **Use `workspace:*` protocol** for local package dependencies
- **Root package must list all workspace packages** as dependencies for proper symlinking
- **ReScript packages must be listed in both** `package.json` and `rescript.json`

### Example: Adding a New Package

```json
// Root package.json
{
  "dependencies": {
    "@rescript-bun-monorepo/new-package": "workspace:*"
  }
}

// Root rescript.json
{
  "dependencies": ["@rescript-bun-monorepo/new-package"]
}

// In another package that depends on it
{
  "dependencies": {
    "@rescript-bun-monorepo/new-package": "workspace:*"
  }
}
```
