$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$desktop = [Environment]::GetFolderPath('Desktop')
$folders = @('resume/archive', 'profile', 'certifications/badges', 'education/logos', 'projects/supply-chain-lakehouse', 'projects/stock-intelligence-pipeline', 'logos/companies', 'logos/tools', 'insights')
foreach ($folder in $folders) {
    [void](New-Item -ItemType Directory -Force -Path (Join-Path $root $folder))
}

$documents = @(
    @{ Source = 'MukeshVarma_DataEngineer_Resume.pdf'; Target = 'resume/Mukesh_Varma_Data_Engineer_Resume.pdf' },
    @{ Source = 'VIT Graduation Certificate - Mukesh_compressed.pdf'; Target = 'education/graduation-certificate.pdf' }
)
foreach ($document in $documents) {
    $source = Join-Path $desktop $document.Source
    $target = Join-Path $root $document.Target
    if ((Test-Path -LiteralPath $source) -and -not (Test-Path -LiteralPath $target)) {
        Copy-Item -LiteralPath $source -Destination $target
    }
}

$icons = @(
    @{ File = 'databricks.svg'; Label = 'Databricks'; Source = 'https://api.iconify.design/logos/databricks-icon.svg' },
    @{ File = 'apache-spark.svg'; Label = 'Apache Spark'; Source = 'https://api.iconify.design/logos/apache-spark.svg' },
    @{ File = 'delta-lake.svg'; Label = 'Delta Lake'; Source = 'https://raw.githubusercontent.com/delta-io/delta/master/docs/src/assets/delta-lake-logo-light.svg' },
    @{ File = 'azure-data-factory.svg'; Label = 'Azure Data Factory'; Source = 'https://api.iconify.design/devicon/azuredatafactory.svg' },
    @{ File = 'Azure Cloud.svg'; Label = 'Azure Cloud'; Source = 'https://api.iconify.design/logos/microsoft-azure.svg' },
    @{ File = 'unity-catalog.svg'; Label = 'Unity Catalog'; Source = 'https://api.iconify.design/logos/databricks-icon.svg' },
    @{ File = 'python.svg'; Label = 'Python'; Source = 'https://api.iconify.design/logos/python.svg' },
    @{ File = 'sql.svg'; Label = 'SQL'; Source = 'https://api.iconify.design/material-symbols/sql.svg?color=%233b6474' },
    @{ File = 'Excel.svg'; Label = 'Excel'; Source = 'https://api.iconify.design/thesvg-color/microsoft-excel.svg' },
    @{ File = 'Power-Automate.svg'; Label = 'Power Automate'; ArchiveEntry = 'Power Platform/PowerAutomate_scalable.svg' },
    @{ File = 'Power-Apps.svg'; Label = 'Power Apps'; ArchiveEntry = 'Power Platform/PowerApps_scalable.svg' },
    @{ File = 'AWS.svg'; Label = 'AWS'; Source = 'https://api.iconify.design/logos/aws.svg' },
    @{ File = 'GCP.svg'; Label = 'Google Cloud'; Source = 'https://api.iconify.design/logos/google-cloud.svg' },
    @{ File = 'dbt.svg'; Label = 'dbt'; Source = 'https://api.iconify.design/logos/dbt-icon.svg' },
    @{ File = 'snowflake.svg'; Label = 'Snowflake'; Source = 'https://api.iconify.design/logos/snowflake-icon.svg' },
    @{ File = 'ssis.svg'; Label = 'SSIS'; Source = 'https://api.iconify.design/devicon/microsoftsqlserver.svg' },
    @{ File = 'Sharepoint.svg'; Label = 'SharePoint'; Source = 'https://api.iconify.design/thesvg-color/microsoft-sharepoint.svg' },
    @{ File = 'azure-blob-storage.svg'; Label = 'Azure Blob Storage'; Source = 'https://api.iconify.design/thesvg-color/azure-blob.svg' },
    @{ File = 'power-bi.svg'; Label = 'Power BI'; Source = 'https://api.iconify.design/logos/microsoft-power-bi.svg' }
)

Add-Type -AssemblyName System.IO.Compression.FileSystem
$archivePath = Join-Path ([System.IO.Path]::GetTempPath()) 'portfolio-power-platform-icons.zip'
if (-not (Test-Path -LiteralPath $archivePath)) {
    Invoke-WebRequest -UseBasicParsing -Uri 'https://download.microsoft.com/download/498606aa-6d27-4f13-aa5c-1401078c153b/Power-Platform-icons-scalable.zip' -OutFile $archivePath
}
$archive = [System.IO.Compression.ZipFile]::OpenRead($archivePath)
try {
    foreach ($icon in $icons) {
        $target = Join-Path $root ('logos/tools/' + $icon.File)
        if (Test-Path -LiteralPath $target) { continue }
        if ($icon.ArchiveEntry) {
            $entry = $archive.GetEntry($icon.ArchiveEntry)
            if (-not $entry) { throw "Missing archive entry: $($icon.ArchiveEntry)" }
            $reader = [System.IO.StreamReader]::new($entry.Open())
            try { $source = $reader.ReadToEnd() } finally { $reader.Dispose() }
        } else {
            $source = (Invoke-WebRequest -UseBasicParsing -Uri $icon.Source -TimeoutSec 30).Content
        }
        $original = [System.Xml.XmlDocument]::new()
        $original.LoadXml($source)
        if ($original.DocumentElement.LocalName -ne 'svg') { throw "Invalid SVG: $($icon.File)" }
        $tile = [System.Xml.XmlDocument]::new()
        $tile.LoadXml('<svg xmlns="http://www.w3.org/2000/svg" width="224" height="64" viewBox="0 0 224 64" role="img"><rect x="0.5" y="0.5" width="223" height="63" rx="4" fill="#fff" stroke="#e2e8e5"/></svg>')
        $nested = $tile.ImportNode($original.DocumentElement, $true)
        $nested.SetAttribute('x', '14')
        $nested.SetAttribute('y', '12')
        $nested.SetAttribute('width', '40')
        $nested.SetAttribute('height', '40')
        $nested.SetAttribute('preserveAspectRatio', 'xMidYMid meet')
        [void]$tile.DocumentElement.AppendChild($nested)
        $text = $tile.CreateElement('text', 'http://www.w3.org/2000/svg')
        $text.SetAttribute('x', '65')
        $text.SetAttribute('y', '37')
        $text.SetAttribute('font-family', 'Arial, sans-serif')
        $text.SetAttribute('font-size', $(if ($icon.Label.Length -gt 15) { '14' } else { '16' }))
        $text.SetAttribute('font-weight', '600')
        $text.SetAttribute('fill', '#202825')
        $text.InnerText = $icon.Label
        [void]$tile.DocumentElement.AppendChild($text)
        $tile.Save($target)
        Write-Output "Created $($icon.File)"
    }
} finally {
    $archive.Dispose()
}