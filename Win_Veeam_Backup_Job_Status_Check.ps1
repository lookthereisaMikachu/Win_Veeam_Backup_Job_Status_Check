<#
.SYNOPSIS
   Check the status of Veeam backup jobs.

.DESCRIPTION
   This script checks the status of a specific Veeam backup job or all backup jobs completed within the last 24 hours.
   It returns a specific code based on the results: 0 (Success), 1 (Warning), 2 (Failure), or 3 (No backups or job not found).

.PARAMETER JobName
   The name of the Veeam backup job to check. If not provided, the script evaluates all jobs in the last 24 hours.

.OUTPUTS
   Numeric return code indicating the status of the backup(s).

.EXAMPLE
   .\Win_Veeam_Backup_Job_Status_Check.ps1 -JobName "DailyBackup"
   Checks the status of the "DailyBackup" job and returns a corresponding code.

.EXAMPLE
   .\Win_Veeam_Backup_Job_Status_Check.ps1
   Checks the status of all jobs completed in the last 24 hours and returns a corresponding code.

.NOTES
   Version: 1.0
   Author: lookthereisaMikachu
   Date: 25.11.2024
   This script requires the Veeam PowerShell Snap-In. Usually its already installed together with 
   Veeam Backup and Replication.

   The script does not recognize:
   - If Veeam isnt installed
   - If no Jobs are created 
#>

param (
    [string]$JobName = ""
)

# Import the Veeam PowerShell Snap-In
Add-PSSnapin VeeamPSSnapIn -ErrorAction SilentlyContinue

# Initialize the return code
$returnCode = 0

if ($JobName) {
    # Check if the specified job exists
    $job = Get-VBRJob | Where-Object { $_.Name -eq $JobName }

    if (-not $job) {
        # If the job does not exist, set return code to 3
        $returnCode = 3
    } else {
        # Retrieve the last backup session for the specified job
        $session = Get-VBRBackupSession | Where-Object { $_.JobName -eq $JobName } | Sort-Object EndTime -Descending | Select-Object -First 1

        if (-not $session) {
            # If no session for the job was found in the last 24 hours
            $returnCode = 3
        } else {
            # Check the status of the last session and set the return code
            $status = $session.Result

            if ($status -eq "Failed") {
                $returnCode = 2
            } elseif ($status -eq "Warning") {
                $returnCode = 1
            } else {
                $returnCode = 0
            }
        }
    }
} else {
    # Retrieve backup sessions from the last 24 hours for all jobs
    $timeSpan = (Get-Date).AddDays(-1)
    $sessions = Get-VBRBackupSession | Where-Object { $_.EndTime -gt $timeSpan }

    if (-not $sessions) {
        # If no sessions were found
        $returnCode = 3
    } else {
        # Check all sessions and set the highest return code
        foreach ($session in $sessions) {
            $status = $session.Result

            if ($status -eq "Failed") {
                $returnCode = 2
                break
            } elseif ($status -eq "Warning" -and $returnCode -ne 2) {
                $returnCode = 1
            }
        }
    }
}

# Output the return code and exit
exit $returnCode
