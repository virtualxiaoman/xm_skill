[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$SourcePath,

    [string]$OutputPath,

    [ValidateScript({ $_ -gt 0 -and -not [double]::IsPositiveInfinity($_) })]
    [double]$Scale = 3,

    [ValidateRange(0, [int]::MaxValue)]
    [int]$Border = 5,

    [ValidateRange(1, [int]::MaxValue)]
    [int]$Page = 1,

    [string]$DrawioExe = 'F:\Tools\drawio\draw.io\draw.io.exe',

    [switch]$Overwrite
)

$ErrorActionPreference = 'Stop'
$source = Get-Item -LiteralPath $SourcePath
if ($source -isnot [System.IO.FileInfo] -or $source.Extension -ne '.drawio') {
    throw "Expected a .drawio source file: $SourcePath"
}

$executable = Get-Item -LiteralPath $DrawioExe
if ($executable -isnot [System.IO.FileInfo] -or $executable.Extension -ne '.exe') {
    throw "Expected the draw.io desktop executable: $DrawioExe"
}

$output = [System.IO.Path]::ChangeExtension($source.FullName, '.png')
if ($OutputPath) {
    $output = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($OutputPath)
}
if ([System.IO.Path]::GetExtension($output) -ne '.png') {
    throw "Expected a .png output path: $output"
}
if ((Test-Path -LiteralPath $output) -and -not $Overwrite) {
    throw "The PNG already exists. Use -Overwrite to replace it: $output"
}

$outputDirectory = [System.IO.Path]::GetDirectoryName($output)
$null = [System.IO.Directory]::CreateDirectory($outputDirectory)
$stagedBase = Join-Path $outputDirectory ('.drawio-export-{0}' -f [guid]::NewGuid().ToString('N'))
$temporaryXml = $stagedBase + '.xml'
$renderedPng = $stagedBase + '-rendered.png'
$stagedPng = $stagedBase + '.png'
$invariant = [System.Globalization.CultureInfo]::InvariantCulture
$scaleArgument = $Scale.ToString($invariant)

function Invoke-DrawioExport([string]$Options, [string]$InputFile, [string]$OutputFile) {
    $arguments = '--export {0} --output "{1}" "{2}"' -f $Options, $OutputFile, $InputFile
    $process = Start-Process -FilePath $executable.FullName -ArgumentList $arguments -WindowStyle Hidden -Wait -PassThru
    if ($process.ExitCode -ne 0 -or -not (Test-Path -LiteralPath $OutputFile -PathType Leaf)) {
        throw "draw.io export failed (exit code $($process.ExitCode)): $InputFile"
    }
}

function Find-PngContentEdge([System.Drawing.Bitmap]$Bitmap, [switch]$ScanRows, [switch]$FromEnd) {
    $depthLength = $Bitmap.Width
    $spanLength = $Bitmap.Height
    if ($ScanRows) {
        $depthLength = $Bitmap.Height
        $spanLength = $Bitmap.Width
    }
    for ($offset = 0; $offset -lt $depthLength; $offset++) {
        $depth = $offset
        if ($FromEnd) {
            $depth = $depthLength - 1 - $offset
        }
        for ($span = 0; $span -lt $spanLength; $span++) {
            $pixel = if ($ScanRows) { $Bitmap.GetPixel($span, $depth) } else { $Bitmap.GetPixel($depth, $span) }
            if ($pixel.A -gt 0) {
                return $depth
            }
        }
    }
    return -1
}

try {
    $renderSource = $source.FullName
    $diagram = [System.Xml.XmlDocument]::new()
    $diagram.XmlResolver = $null
    $diagram.Load($renderSource)
    $modelPath = "/mxGraphModel[$Page=1] | /mxfile/diagram[$Page]/mxGraphModel"
    $model = $diagram.SelectSingleNode($modelPath)
    if ($null -eq $model) {
        # Native draw.io handles compressed pages.
        Invoke-DrawioExport '-f xml --uncompressed' $renderSource $temporaryXml
        $diagram.Load($temporaryXml)
        $model = $diagram.SelectSingleNode($modelPath)
        if ($null -eq $model) {
            throw "Cannot find page $Page in $($source.FullName)"
        }
    }
    if ($model.HasAttribute('background')) {
        # Desktop 29.3.6 applies the page color even with --transparent.
        $model.RemoveAttribute('background')
        $diagram.Save($temporaryXml)
        $renderSource = $temporaryXml
    }

    $pngOptions = '--format png --transparent --scale {0} --border 1 --page-index {1}' -f $scaleArgument, $Page
    Invoke-DrawioExport $pngOptions $renderSource $renderedPng
    Add-Type -AssemblyName System.Drawing
    $image = [System.Drawing.Bitmap]::new($renderedPng)
    try {
        if ($image.RawFormat.Guid -ne [System.Drawing.Imaging.ImageFormat]::Png.Guid) {
            throw "The draw.io export is not a valid PNG: $($source.FullName)"
        }

        # Use the visible pixel bounds so the final margin is independent of export scale.
        $left = Find-PngContentEdge $image
        if ($left -lt 0) {
            $content = [System.Drawing.Rectangle]::new(0, 0, $image.Width, $image.Height)
        } else {
            $top = Find-PngContentEdge $image -ScanRows
            $right = Find-PngContentEdge $image -FromEnd
            $bottom = Find-PngContentEdge $image -ScanRows -FromEnd
            $content = [System.Drawing.Rectangle]::FromLTRB($left, $top, $right + 1, $bottom + 1)
        }
        $width = $content.Width + 2 * $Border
        $height = $content.Height + 2 * $Border
        $png = [System.Drawing.Bitmap]::new($width, $height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        try {
            $graphics = [System.Drawing.Graphics]::FromImage($png)
            try {
                $graphics.CompositingMode = [System.Drawing.Drawing2D.CompositingMode]::SourceCopy
                $destination = [System.Drawing.Rectangle]::new($Border, $Border, $content.Width, $content.Height)
                $graphics.DrawImage($image, $destination, $content, [System.Drawing.GraphicsUnit]::Pixel)
            } finally {
                $graphics.Dispose()
            }
            $png.Save($stagedPng, [System.Drawing.Imaging.ImageFormat]::Png)
        } finally {
            $png.Dispose()
        }
    } finally {
        $image.Dispose()
    }

    if ($Overwrite -and [System.IO.File]::Exists($output)) {
        [System.IO.File]::Replace($stagedPng, $output, [System.Management.Automation.Language.NullString]::Value)
    } else {
        [System.IO.File]::Move($stagedPng, $output)
    }

    [PSCustomObject]@{
        Source = $source.FullName
        Output = $output
        Page = $Page
        Width = $width
        Height = $height
    }
} finally {
    foreach ($temporaryFile in @($temporaryXml, $renderedPng, $stagedPng)) {
        if (Test-Path -LiteralPath $temporaryFile -PathType Leaf) {
            Remove-Item -LiteralPath $temporaryFile
        }
    }
}
