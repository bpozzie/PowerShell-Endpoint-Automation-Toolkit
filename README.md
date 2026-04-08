
# PowerShell Endpoint Automation Toolkit

A small, sanitized PowerShell toolkit demonstrating practical automation and diagnostics for Windows endpoints.

The scripts in this repository reflect real-world system administration tasks such as health checks, deployment validation, and troubleshooting.  
All examples are intentionally generic and contain **no organization-specific infrastructure details**.
PowerShell utilities focused on endpoint diagnostics, troubleshooting, and deployment readiness.

---

## Goals

- Demonstrate a troubleshooting and automation mindset
- Show clear, reusable PowerShell structure
- Provide examples useful for Windows endpoint environments
- Keep all examples safe for public sharing
- Avoid organization-specific domains, server paths, or internal identifiers

---

## Repository Structure

```
docs/
    Documentation and reference notes

examples/
    Audit-OrphanedUserProfiles.ps1
    Collect-SystemDiagnostics.ps1
    Scan-EndpointHealth.ps1
    Test-DeploymentReadiness.ps1

LICENSE
README.md
```

Scripts in the **examples** folder are intentionally sanitized so they can be safely shared publicly.

---

## Included Examples

### Scan-EndpointHealth.ps1
Collects a quick health snapshot from a Windows endpoint, including:

- Operating system information
- Disk status
- Service health
- Basic system diagnostics

---

### Test-DeploymentReadiness.ps1
Checks whether a system is ready for software deployment by validating:

- Disk space
- Operating system version
- Required services
- Basic environment readiness

---

### Collect-SystemDiagnostics.ps1
Gathers troubleshooting information useful for diagnosing endpoint problems.

Examples of collected information may include:

- system configuration
- running services
- event log summaries
- environment details

---

### Audit-OrphanedUserProfiles.ps1
Scans Windows user profile registry entries and identifies profiles that may be orphaned or in a failed state.

This script inspects the following registry location:

```
HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList
```

and reports profiles with suspicious state values.

---

## Example Workflow

A typical endpoint troubleshooting workflow might look like:

1. Run **Scan-EndpointHealth.ps1** to capture a quick system overview  
2. Run **Test-DeploymentReadiness.ps1** before pushing software updates  
3. Use **Collect-SystemDiagnostics.ps1** for deeper troubleshooting  
4. Use **Audit-OrphanedUserProfiles.ps1** to detect profile corruption or orphaned accounts  

---

## License

This project is released under the **MIT License**.

---

## Author

Barry M. Page
