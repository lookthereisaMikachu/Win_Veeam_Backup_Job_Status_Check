# Übersicht

Dieses Skript dient dazu, den Status von Veeam-Backup-Jobs zu überprüfen und anhand des letzten Backupsitzungsstatus einen spezifischen Code zurückzugeben. Es kann den Status eines einzelnen Jobs oder aller Jobs in den letzten 24 Stunden auswerten.

## Voraussetzungen

1. **Veeam Backup & Replication** muss installiert und konfiguriert sein.
2. Das **Veeam PowerShell-Snap-In** muss verfügbar und zugänglich sein.
3. Das Skript muss in einer **PowerShell-Umgebung** mit Administratorrechten ausgeführt werden.

---

## Funktionsweise des Skripts

- **Prüfen eines spezifischen Backup-Jobs:** Wenn ein Job-Name angegeben wird, überprüft das Skript, ob der Job existiert, und ermittelt den Status der letzten Sitzung.
- **Prüfen aller Backup-Jobs:** Wenn kein Job-Name angegeben wird, wertet das Skript alle in den letzten 24 Stunden abgeschlossenen Backup-Jobs aus.
- **Rückgabecodes:**
  - `0`: Erfolgreich — Keine Fehler oder Warnungen gefunden.
  - `1`: Warnung — Mindestens ein Job hat eine Warnung gemeldet.
  - `2`: Fehler — Mindestens ein Job ist fehlgeschlagen.
  - `3`: Keine Backups gefunden oder der angegebene Job existiert nicht.

---

## Verwendung des Skripts

### 1. PowerShell öffnen

- Stellen Sie sicher, dass die PowerShell-Konsole mit Administratorrechten ausgeführt wird.

### 2. Skript ausführen

#### a) Überprüfung eines spezifischen Jobs
Um den Status eines spezifischen Backup-Jobs zu überprüfen, verwenden Sie:

```powershell
.\BackupStatusChecker.ps1 -JobName "IhrJobName"
```

- Ersetzen Sie `IhrJobName` durch den Namen des Backup-Jobs, den Sie überprüfen möchten.

### 3. Rückgabecode interpretieren

Nach der Ausführung gibt das Skript einen der folgenden Rückgabecodes zurück:

| Code | Beschreibung                                         |
|------|-----------------------------------------------------|
| `0`  | Alle Backups wurden erfolgreich abgeschlossen.      |
| `1`  | Mindestens ein Backup hat eine Warnung gemeldet.    |
| `2`  | Mindestens ein Backup ist fehlgeschlagen.           |
| `3`  | Keine Backups in den letzten 24 Stunden gefunden oder Job nicht vorhanden.|

---

## Beispiele

### Prüfung eines spezifischen Jobs

```powershell
.\BackupStatusChecker.ps1 -JobName "TäglichesBackup"
```

- Wenn der Job `TäglichesBackup` erfolgreich war, gibt das Skript `0` zurück.
- Wenn der Job fehlgeschlagen ist, gibt es `2` zurück.

---

## Hinweise

- Das Skript generiert keine visuelle Ausgabe, sondern gibt nur einen numerischen Code zurück.
- Sie können dieses Skript in Automatisierungspipelines oder Monitoring-Tools integrieren, um den Status Ihrer Backup-Operationen zu überwachen.
