$tache = Get-ScheduledTask -TaskName Shutdown

if ($tache.State -eq 'Ready') {
    Disable-ScheduledTask $tache
}

shutdown /a