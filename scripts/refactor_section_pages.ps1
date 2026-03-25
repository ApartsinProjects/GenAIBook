$files = @(
  'E:\Projects\GenAIBook\front-matter\index.html',
  'E:\Projects\GenAIBook\part-1-orientation-and-fast-start\index.html',
  'E:\Projects\GenAIBook\part-2-data-and-experimental-foundations\index.html',
  'E:\Projects\GenAIBook\part-3-representations-architectures-and-model-selection\index.html',
  'E:\Projects\GenAIBook\part-4-synthetic-data-design-and-operations\index.html',
  'E:\Projects\GenAIBook\part-5-training-multimodal-systems-and-operations\index.html',
  'E:\Projects\GenAIBook\part-6-applications-frontiers-and-capstones\index.html',
  'E:\Projects\GenAIBook\appendices\index.html'
)

function Get-Extras([string]$title) {
  switch -Regex ($title) {
    'Embeddings|Self-Supervision|Representation' {
@'
<div class="label">Deep Dive</div>
<ul>
  <li>Inner workings of embedding construction, pooling, contrastive objectives, and why representation geometry matters for retrieval and filtering.</li>
  <li>Algorithmic discussion of positive and negative pairs, masked prediction, collapse risks, and how representation failures show up downstream.</li>
</ul>
<div class="label">Illustrations</div>
<ul>
  <li>Embedding-space diagrams, positive-vs-negative pair graphics, clustering views, and nearest-neighbor retrieval schematics.</li>
</ul>
<div class="label">Worked Example</div>
<ul>
  <li>Build an embedding index for one multimodal slice, inspect neighbors, and show how representation errors influence relabeling or QA.</li>
</ul>
'@
    }
    'Attention|Transformers|Fusion' {
@'
<div class="label">Deep Dive</div>
<ul>
  <li>Mechanics of attention scores, token mixing, positional information, connector modules, and the cost-quality tradeoffs between dual encoders and cross-attention systems.</li>
  <li>Why multimodal fusion choices change memory use, latency, grounding quality, and long-context behavior.</li>
</ul>
<div class="label">Illustrations</div>
<ul>
  <li>Token-flow diagrams, attention heatmaps, connector schematics, and side-by-side fusion architecture comparisons.</li>
</ul>
<div class="label">Worked Example</div>
<ul>
  <li>Trace one image-text and one audio-text query through dual-encoder and cross-attention pipelines and compare output behavior and compute cost.</li>
</ul>
'@
    }
    'Generative Model Families|Image Data|Video Data|Audio Data|Simulation' {
@'
<div class="label">Deep Dive</div>
<ul>
  <li>Inner workings of the core generation mechanism, conditioning path, sampling or decoding loop, and the engineering consequences of those choices for controllability and label fidelity.</li>
  <li>Discussion of where the model family is useful for synthetic data, where it fails, and what artifacts or biases it tends to introduce.</li>
</ul>
<div class="label">Illustrations</div>
<ul>
  <li>Pipeline schematics for generation, editing, conditioning, or simulation control; temporal diagrams where time is a first-class variable; and label-flow diagrams from generator to QA.</li>
</ul>
<div class="label">Worked Example</div>
<ul>
  <li>Walk through one end-to-end synthetic-data recipe, show the conditioning inputs, generated outputs, QA gates, and the final training-ready artifact.</li>
</ul>
'@
    }
    'Foundation Models|Document AI|Omni Systems|Retrieval|RAG|Agent Systems' {
@'
<div class="label">Deep Dive</div>
<ul>
  <li>Mechanism-level treatment of how foundation models are wired for perception, grounding, retrieval, and generation, including what remains modular versus unified.</li>
  <li>System-level discussion of why retrieval, tool use, schema validation, and grounding often outperform naive end-to-end prompting.</li>
</ul>
<div class="label">Illustrations</div>
<ul>
  <li>System architecture diagrams, document or multimodal retrieval pipelines, grounding loops, and modular-vs-omni design comparisons.</li>
</ul>
<div class="label">Worked Example</div>
<ul>
  <li>Assemble a retrieval-grounding-generation workflow with explicit intermediate artifacts, then compare it with a direct omni-model baseline.</li>
</ul>
'@
    }
    'Fine-Tuning|Inference Engineering|Deployment|Monitoring|Debugging' {
@'
<div class="label">Deep Dive</div>
<ul>
  <li>Algorithmic treatment of what changes during adaptation, where gains can come from synthetic mixtures, and how optimization, quantization, serving, and monitoring choices interact.</li>
  <li>Failure-mode discussion that separates data problems, optimization problems, runtime regressions, and post-deployment drift.</li>
</ul>
<div class="label">Illustrations</div>
<ul>
  <li>Training-to-serving lifecycle diagrams, ablation tables, latency-quality tradeoff charts, and drift or failure-bucket dashboards.</li>
</ul>
<div class="label">Worked Example</div>
<ul>
  <li>Run one training or deployment decision from baseline through evaluation, then show the regression checks or monitoring signals that justify the final choice.</li>
</ul>
'@
    }
    default {
@'
<div class="label">Deep Dive</div>
<ul>
  <li>First-principles treatment of the core decision logic in this chapter, including why the workflow exists, what assumptions it makes, and which downstream chapters depend on getting it right.</li>
  <li>Discussion of the most common failure modes when teams skip this step or reduce it to checklist work.</li>
</ul>
<div class="label">Illustrations</div>
<ul>
  <li>Decision trees, workflow maps, schema diagrams, evaluation matrices, or project-roadmap graphics that make the chapter operational instead of purely verbal.</li>
</ul>
<div class="label">Worked Example</div>
<ul>
  <li>One concrete case-study walkthrough showing how the chapter's framework changes a real modeling or data decision.</li>
</ul>
'@
    }
  }
}

function Add-AnchorIds([string]$content) {
  $content = [regex]::Replace(
    $content,
    '<h3><span id="span-id-[^"]+"><span id="([^"]+)">(.*?)</span></span></h3>',
    '<h3><span id="$1">$2</span></h3>',
    'Singleline'
  )

  return [regex]::Replace(
    $content,
    '(<article class="chapter">\s*<div class="chapter-no">.*?</div>\s*<div>\s*<h3>)(?!<span id=")(.*?)(</h3>)',
    {
      param($m)
      $title = $m.Groups[2].Value
      $slug = (($title.ToLower() -replace '[^a-z0-9]+', '-') -replace '(^-|-$)', '')
      $m.Groups[1].Value + '<span id="' + $slug + '">' + $title + '</span>' + $m.Groups[3].Value
    },
    'Singleline'
  )
}

function Add-ChapterJumpList([string]$content) {
  if ($content -match 'Chapter Jump List') {
    return $content
  }

  $titles = [regex]::Matches(
    $content,
    '<div class="chapter-no">(.*?)</div>\s*<div>\s*<h3><span id="(.*?)">(.*?)</span></h3>',
    'Singleline'
  )

  if ($titles.Count -eq 0) {
    return $content
  }

  $items = foreach ($match in $titles) {
    $no = $match.Groups[1].Value.Trim()
    $slug = $match.Groups[2].Value.Trim()
    $title = $match.Groups[3].Value.Trim()
    '    <li><a href="#' + $slug + '">' + $no + ' - ' + $title + '</a></li>'
  }

  $jump = @"
<section class="panel">
  <h2>Chapter Jump List</h2>
  <ul class="chapter-anchor-list">
$($items -join "`r`n")
  </ul>
</section>
"@

  return [regex]::Replace(
    $content,
    '(<div class="topbar">.*?</div>\s*)(<section class="part" id="[^"]+">)',
    '$1' + $jump + "`r`n" + '$2',
    'Singleline'
  )
}

function Add-ExtrasAndBoundaries([string]$content) {
  return [regex]::Replace(
    $content,
    '<article class="chapter">(.*?)</article>',
    {
      param($m)
      $article = $m.Groups[1].Value
      $titleMatch = [regex]::Match($article, '<h3>(?:<span id=".*?">)?(.*?)(?:</span>)?</h3>')
      if (-not $titleMatch.Success) {
        return $m.Value
      }

      $title = $titleMatch.Groups[1].Value

      if ($article -notmatch '<div class="label">Deep Dive</div>') {
        $extras = Get-Extras $title
        if ($article -match '<div class="label">Learning Outcomes</div>') {
          $article = $article -replace '<div class="label">Learning Outcomes</div>', ($extras + "`r`n<div class=""label"">Learning Outcomes</div>")
        } else {
          $article += "`r`n" + $extras
        }
      }

      if ($title -eq 'Annotation Systems, Weak Supervision, and Auto-Labeling') {
        $article = $article -replace 'Treats labeling as a system, not a manual afterthought\.', 'Treats label creation, correction, and weak-supervision workflows as a system before generation-time QA begins.'
        if ($article -notmatch 'Boundary note: this chapter is about creating and repairing labels; Chapter 19 is about accepting or rejecting synthetic outputs after generation; Chapter 25 is about failures that only appear after deployment\.') {
          $article = $article -replace '<li>Label disagreement, noisy labels, correction queues, interpolation workflows, and annotation-ops productivity metrics\.</li>', '<li>Label disagreement, noisy labels, correction queues, interpolation workflows, and annotation-ops productivity metrics.</li><li>Boundary note: this chapter is about creating and repairing labels; Chapter 19 is about accepting or rejecting synthetic outputs after generation; Chapter 25 is about failures that only appear after deployment.</li>'
        }
        $article = $article -replace '(<li>Boundary note: this chapter is about creating and repairing labels; Chapter 19 is about accepting or rejecting synthetic outputs after generation; Chapter 25 is about failures that only appear after deployment\.</li>){2,}', '<li>Boundary note: this chapter is about creating and repairing labels; Chapter 19 is about accepting or rejecting synthetic outputs after generation; Chapter 25 is about failures that only appear after deployment.</li>'
      }

      if ($title -eq 'Synthetic Data Operations: QA, Filtering, Reward Models, and Judge Loops') {
        $article = $article -replace 'Focuses on operational QA after generation or repurposing so it does not blur together with the earlier chapter on annotation systems and auto-labeling\.', 'Focuses on post-generation acceptance QA for synthetic or repurposed data so it stays distinct from label creation in Chapter 7 and distinct from post-deployment monitoring in Chapter 25.'
        if ($article -notmatch 'Boundary note: this chapter decides whether generated assets enter the dataset at all; it is not the chapter for production telemetry, drift, or incident response\.') {
          $article = $article -replace '<li>Stopping criteria, iteration policies, and sample acceptance/rejection logging for generation campaigns\.</li>', '<li>Stopping criteria, iteration policies, and sample acceptance/rejection logging for generation campaigns.</li><li>Boundary note: this chapter decides whether generated assets enter the dataset at all; it is not the chapter for production telemetry, drift, or incident response.</li>'
        }
        $article = $article -replace '(<li>Boundary note: this chapter decides whether generated assets enter the dataset at all; it is not the chapter for production telemetry, drift, or incident response\.</li>){2,}', '<li>Boundary note: this chapter decides whether generated assets enter the dataset at all; it is not the chapter for production telemetry, drift, or incident response.</li>'
      }

      if ($title -eq 'Monitoring, Drift, and Failure Analysis in the Wild') {
        $article = $article -replace 'Adds the missing post-deployment chapter on feedback loops, drift detection, rollback logic, and failure triage\.', 'Adds the post-deployment chapter on telemetry, drift detection, rollback logic, and failure triage after a system is already live.'
        if ($article -notmatch 'Boundary note: this chapter begins only after deployment; dataset-label creation belongs in Chapter 7, and synthetic-asset acceptance QA belongs in Chapter 19\.') {
          $article = $article -replace '<li>User feedback loops, production trace capture, and post-deployment synthetic-data refresh cycles\.</li>', '<li>User feedback loops, production trace capture, and post-deployment synthetic-data refresh cycles.</li><li>Boundary note: this chapter begins only after deployment; dataset-label creation belongs in Chapter 7, and synthetic-asset acceptance QA belongs in Chapter 19.</li>'
        }
        $article = $article -replace '(<li>Boundary note: this chapter begins only after deployment; dataset-label creation belongs in Chapter 7, and synthetic-asset acceptance QA belongs in Chapter 19\.</li>){2,}', '<li>Boundary note: this chapter begins only after deployment; dataset-label creation belongs in Chapter 7, and synthetic-asset acceptance QA belongs in Chapter 19.</li>'
      }

      if ($title -eq 'Foundation Models, Document AI, and Omni Systems in Practice') {
        $article = $article -replace 'Covers vision-language, audio-language, video-language, document-centric, segmentation, grounding, and omni-style model families with a focus on where each one belongs in a real system\.', 'Covers foundation-model families with a selection focus, showing where each belongs in a real system before later chapters build full retrieval, RAG, and agent workflows on top of them.'
      }

      return '<article class="chapter">' + $article + '</article>'
    },
    'Singleline'
  )
}

foreach ($file in $files) {
  $content = Get-Content -Raw -Path $file

  if ($content -notmatch '\.chapter-anchor-list') {
    $replacement = '$1' + "`r`n  .chapter-anchor-list { list-style:none; margin:0; padding:0; display:grid; gap:8px; }`r`n  .chapter-anchor-list li { margin:0; }`r`n  .chapter-anchor-list a { text-decoration:none; color:var(--accent); }"
    $content = $content -replace '(\.mini-nav a \{ text-decoration:none; color:var\(--accent\); \})', $replacement
  }

  $content = Add-AnchorIds $content
  $content = Add-ChapterJumpList $content
  $content = Add-ExtrasAndBoundaries $content
  $content = $content -replace '>\s+<', ">`r`n<"

  Set-Content -Path $file -Value $content -Encoding UTF8
}
