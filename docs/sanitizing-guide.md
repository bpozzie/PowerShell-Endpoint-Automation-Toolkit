# Sanitizing Existing PowerShell Before Public Sharing

Use this checklist before posting any script publicly.

## Remove or replace:

- Real domain names
- Real organization names
- Internal shares such as `\\server\share`
- Site names, school names, district names, or building abbreviations
- IP addresses that identify internal infrastructure
- Invitation codes, API keys, tokens, passwords, or secrets
- Usernames tied to production environments
- Internal comments that reveal environment details

## Replace with generic examples:

- `example.local`
- `fileserver`
- `\\server\share\Logs`
- `C:\ProgramData\Toolkit`
- `example-user`
- `example-token`

## Good public comment style

Instead of:

> Copy package to the SAU23 deployment share and log to the district reports server.

Use:

> Copy package to a central deployment share and write logs to a configurable path.

## Extra caution

Review:

- variables
- comments
- default parameter values
- transcript paths
- log file names
- hard-coded package locations
