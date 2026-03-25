$ErrorActionPreference = "Stop"

$repo = "E:\Projects\GenAIBook"

$chapterTags = @{
  "FM0" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "FM1" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "FM2" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "FM3" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "FM4" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "FM5" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "01" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "02" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "03" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "04" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "05" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "06" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "07" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "08" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "09" = @("Advanced","Undergraduate","Graduate","Engineering","Research")
  "10" = @("Advanced","Undergraduate","Graduate","Engineering","Research")
  "11" = @("Advanced","Undergraduate","Graduate","Engineering","Research")
  "12" = @("Advanced","Graduate","Engineering","Research")
  "13" = @("Advanced","Graduate","Engineering","Research")
  "14" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "15" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "16" = @("Advanced","Undergraduate","Graduate","Engineering","Research")
  "17" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "18" = @("Advanced","Graduate","Engineering","Research")
  "19" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "20" = @("Advanced","Graduate","Engineering","Research")
  "21" = @("Advanced","Graduate","Engineering","Research")
  "22" = @("Advanced","Graduate","Engineering","Research")
  "23" = @("Advanced","Graduate","Engineering","Research")
  "24" = @("Advanced","Graduate","Engineering","Research")
  "25" = @("Advanced","Graduate","Engineering","Research")
  "26" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "27" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "28" = @("Advanced","Graduate","Engineering","Research")
  "29" = @("Advanced","Graduate","Research")
  "30" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "31" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "32" = @("Core","Undergraduate","Graduate","Engineering","Research")
  "A" = @("Core","Undergraduate","Graduate","Engineering")
  "B" = @("Core","Undergraduate","Graduate","Engineering")
  "C" = @("Core","Undergraduate","Graduate","Engineering")
  "D" = @("Advanced","Graduate","Engineering","Research")
  "E" = @("Core","Undergraduate","Graduate","Engineering","Research")
}

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

function New-MetaHtml([string[]]$tags) {
  $items = $tags | ForEach-Object { "<span class=""tag"">$_</span>" }
  return "<div class=""meta"">`r`n" + ($items -join "`r`n") + "`r`n</div>"
}

foreach ($relativePath in $detailPages) {
  $path = Join-Path $repo $relativePath
  $html = Get-Content -Path $path -Raw

  $pattern = '(?s)<article class="chapter">.*?<div class="chapter-no">(?<id>[^<]+)</div>.*?<p class="chapter-desc">.*?</p>(?<rest>.*?)</article>'

  $updated = [regex]::Replace($html, $pattern, {
      param($m)
      $id = $m.Groups["id"].Value.Trim()
      if (-not $chapterTags.ContainsKey($id)) {
        return $m.Value
      }

      $article = $m.Value
      $newMeta = New-MetaHtml $chapterTags[$id]

      if ($article -match '(?s)<div class="meta">.*?</div>') {
        return [regex]::Replace($article, '(?s)<div class="meta">.*?</div>', [System.Text.RegularExpressions.MatchEvaluator]{ param($ignored) $newMeta }, 1)
      }

      return [regex]::Replace(
        $article,
        '(?s)(<p class="chapter-desc">.*?</p>)',
        [System.Text.RegularExpressions.MatchEvaluator]{ param($desc) $desc.Groups[1].Value + "`r`n" + $newMeta },
        1
      )
    })

  Set-Content -Path $path -Value $updated
}

$topLevelPages = @("index.html", "book-toc.html")
foreach ($relativePath in $topLevelPages) {
  $path = Join-Path $repo $relativePath
  $html = Get-Content -Path $path -Raw
  $legendReplacement = @'
<li><strong>Core / Advanced:</strong><br/>Signals whether a chapter is required for most readers or intended as a deeper specialization.</li>
        <li><strong>Undergraduate / Graduate:</strong><br/>Signals where the chapter fits most naturally in the suggested course pathways.</li>
        <li><strong>Engineering / Research:</strong><br/>Signals whether the chapter primarily supports system building, research framing, or both.</li>
        <li><strong>Companion Repo:</strong><br/>Signals that fast-moving tooling and implementation assets live primarily in notebooks and the repo.</li>
'@
  $html = $html -replace '<li><strong>Core:</strong><br/>[^<]+</li>\s*<li><strong>Advanced:</strong><br/>[^<]+</li>\s*<li><strong>Companion Repo:</strong><br/>[^<]+</li>', $legendReplacement.Trim()
  Set-Content -Path $path -Value $html
}
