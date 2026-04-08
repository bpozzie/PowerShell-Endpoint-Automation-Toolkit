# PowerShell Endpoint Automation Toolkit

A small, sanitized portfolio kit that demonstrates a practical Windows automation approach without exposing any organization-specific infrastructure details.

## Goals

- Show a troubleshooting and automation mindset
- Demonstrate clear, reusable PowerShell structure
- Keep all examples safe for public sharing
- Avoid any environment-specific names, domains, server paths, or internal identifiers

## Included Examples

### 1. `Scan-EndpointHealth.ps1`
Collects a basic health snapshot from a Windows endpoint, including:
- Computer name
- OS version
- Last boot time
- Disk free space
- Defender service state
- Recent reboot indicator

Outputs a small object that can be exported to CSV or JSON.

### 2. `Test-DeploymentReadiness.ps1`
Performs a generic pre-deployment readiness check:
- Confirms PowerShell version
- Checks available disk space
- Verifies admin rights
- Confirms Windows Installer service state
- Reports whether a reboot may be pending

### 3. `Collect-SystemDiagnostics.ps1`
Gathers lightweight diagnostic information useful during troubleshooting:
- Running services
- Recent application/system errors
- Network adapter summary
- Installed hotfix summary

## Safe-for-Sharing Rules

Before publishing any script, remove or replace:

- Domain names
- Organization names
- School, district, or agency names
- Internal UNC paths
- Server names or IP addresses
- Real invitation codes, tokens, keys, or secrets
- Usernames tied to real environments
- GPO names, OU names, or internal package paths

Replace them with neutral values such as:

- `contoso.local`
- `fileserver`
- `\\server\share\Logs`
- `C:\ProgramData\Toolkit\Logs`
- `example-token`

## Suggested Repository Structure

```text
PowerShell-Endpoint-Automation-Toolkit/
├── README.md
├── LICENSE
├── .gitignore
├── examples/
│   ├── Scan-EndpointHealth.ps1
│   ├── Test-DeploymentReadiness.ps1
│   └── Collect-SystemDiagnostics.ps1
└── docs/
    └── portfolio-summary.md
```

## How to Present This on GitHub

In your repository description, keep it simple:

> Practical PowerShell examples for endpoint health checks, deployment readiness, and Windows diagnostics.

In your profile or application, you can describe it like this:

> I build PowerShell tools that focus on repeatable diagnostics, deployment safety checks, and operational reliability in Windows environments.

## Notes

These examples are intentionally generic. They are meant to demonstrate structure, judgment, and maintainability—not reveal details of any production environment.
