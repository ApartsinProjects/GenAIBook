$ErrorActionPreference = "Stop"

$repo = "E:\Projects\GenAIBook"
$detailPages = @(
  "front-matter\index.html",
  "part-1-orientation-and-fast-start\index.html",
  "part-2-data-and-experimental-foundations\index.html",
  "part-3-vision-audio-and-generative-model-internals\index.html",
  "part-4-synthetic-data-design-and-operations\index.html",
  "part-5-training-multimodal-systems-and-operations\index.html",
  "part-6-applications-frontiers-and-capstones\index.html",
  "appendices\index.html"
)

foreach ($relativePath in $detailPages) {
  $path = Join-Path $repo $relativePath
  $text = [System.IO.File]::ReadAllText($path)

  $updated = [regex]::Replace(
    $text,
    '(?s)(<div class="meta">.*?)(</div>)',
    {
      param($m)
      $meta = $m.Groups[1].Value
      if ($meta -match '<span class="tag">Companion Repo</span>') {
        return $m.Value
      }
      return $meta + "`r`n<span class=""tag"">Companion Repo</span>" + $m.Groups[2].Value
    }
  )

  [System.IO.File]::WriteAllText($path, $updated, (New-Object System.Text.UTF8Encoding($false)))
}
