# Installe Sergent sur Windows : librairies Python + commande "sergent"
$ErrorActionPreference = "Stop"
$ici = Split-Path -Parent $MyInvocation.MyCommand.Path
if ($ici -like "*\AppData\Local\Temp\*") {
    Write-Host "Tu as lance l'installateur directement dans le ZIP." -ForegroundColor Red
    Write-Host "Fais clic droit sur sergent.zip > Extraire tout..., puis lance installer.cmd dans le dossier extrait." -ForegroundColor Red
    exit 1
}
Write-Host ""
Write-Host "  == Installation de SERGENT ==" -ForegroundColor DarkYellow
Write-Host ""

# 1. Trouver Python (le lanceur py en premier, sinon python)
$py = $null
if (Get-Command py -ErrorAction SilentlyContinue) {
    $py = (& py -3 -c "import sys; print(sys.executable)").Trim()
} elseif (Get-Command python -ErrorAction SilentlyContinue) {
    $py = (& python -c "import sys; print(sys.executable)").Trim()
}
if (-not $py -or -not (Test-Path $py)) {
    Write-Host "Python introuvable. Installe-le avec :  winget install Python.Python.3.12" -ForegroundColor Red
    Write-Host "Puis relance installer.cmd" -ForegroundColor Red
    exit 1
}
Write-Host "Python : $py"

# 2. Librairies
& $py -m pip install --upgrade -r "$ici\requirements.txt"

# 3. Ollama
if (-not (Get-Command ollama -ErrorAction SilentlyContinue)) {
    Write-Host "Ollama introuvable. Installe-le avec :  winget install Ollama.Ollama" -ForegroundColor Yellow
} else {
    Write-Host "Ollama : OK"
}

# 4. Commande "sergent" disponible partout (dossier WindowsApps deja dans le PATH)
$dest = Join-Path $env:LOCALAPPDATA "Microsoft\WindowsApps\sergent.cmd"
$contenu = "@echo off`r`nchcp 65001 >nul`r`n`"$py`" `"$ici\sergent.py`" %*`r`n"
[System.IO.File]::WriteAllText($dest, $contenu, [System.Text.Encoding]::ASCII)

Write-Host ""
Write-Host "  C'est pret! Ouvre un NOUVEAU terminal et tape :  sergent" -ForegroundColor DarkYellow
Write-Host ""
