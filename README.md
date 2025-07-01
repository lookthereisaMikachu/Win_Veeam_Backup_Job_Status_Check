# Overview

This script is used to check the status of Veeam backup jobs and return a specific code based on the last backup session status. It can evaluate the status of a single job or all jobs that completed in the last 24 hours.

## Prerequisites

1. **Veeam Backup & Replication** must be installed and configured.
2. The **Veeam PowerShell Snap-In** must be available and accessible.
3. The script must be executed in a **PowerShell environment** with administrator privileges.

---

## How the Script Works

* **Checking a specific backup job:** If a job name is specified, the script checks whether the job exists and retrieves the status of the last session.
* **Checking all backup jobs:** If no job name is specified, the script evaluates all backup jobs that completed in the last 24 hours.
* **Return codes:**

  * `0`: Success — No errors or warnings found.
  * `1`: Warning — At least one job reported a warning.
  * `2`: Error — At least one job failed.
  * `3`: No backups found or the specified job does not exist.

---

## Using the Script

### 1. Open PowerShell

* Ensure that the PowerShell console is run with administrator privileges.

### 2. Run the Script

#### a) Check a specific job

To check the status of a specific backup job, use:

```powershell
.\Win_Veeam_Backup_Job_Status_Check.ps1 -JobName "YourJobName"
```

* Replace `YourJobName` with the name of the backup job you want to check.

### 3. Interpret the Return Code

After execution, the script returns one of the following return codes:

| Code | Description                                             |
| ---- | ------------------------------------------------------- |
| `0`  | All backups completed successfully.                     |
| `1`  | At least one backup reported a warning.                 |
| `2`  | At least one backup failed.                             |
| `3`  | No backups found in the last 24 hours or job not found. |

---

## Examples

### Check a specific job

```powershell
.\Win_Veeam_Backup_Job_Status_Check.ps1 -JobName "DailyBackup"
```

* If the `DailyBackup` job was successful, the script returns `0`.
* If the job failed, it returns `2`.

---

## Notes

* The script does not generate any visual output; it only returns a numeric code.
* You can integrate this script into automation pipelines or monitoring tools to monitor the status of your backup operations.

---
