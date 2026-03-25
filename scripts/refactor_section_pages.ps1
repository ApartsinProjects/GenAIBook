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

function Get-CoreBlocks([string]$title) {
  switch -Regex ($title) {
    'Embeddings|Self-Supervision|Representation' {
@'
<div class="label">Deep Dive</div>
<ul>
  <li><strong>Inner workings:</strong> embedding construction, pooling, contrastive objectives, and representation geometry for retrieval, filtering, and zero-shot transfer.</li>
  <li><strong>Algorithm sketch:</strong> positive/negative pair formation, masked prediction, projection heads, and nearest-neighbor retrieval loops.</li>
  <li><strong>Intuition:</strong> why semantically useful geometry can act like a reusable substrate before task-specific fine-tuning.</li>
  <li><strong>Tradeoffs:</strong> generic transfer versus task fit, open-world flexibility versus calibration, and retrieval quality versus compute footprint.</li>
  <li><strong>Common failure modes:</strong> collapsed clusters, shortcut features, biased neighborhoods, and brittle zero-shot behavior.</li>
</ul>
<div class="label">Illustrations and Figures</div>
<ul>
  <li>Embedding-space diagrams, positive-vs-negative pair graphics, clustering views, and nearest-neighbor retrieval schematics.</li>
</ul>
<div class="label">Worked Example</div>
<ul>
  <li>Build an embedding index for one multimodal slice, inspect neighbors, and show how representation errors influence relabeling or QA.</li>
</ul>
<div class="label">Case Study Thread</div>
<ul>
  <li>Use the industrial inspection, multilingual speech analytics, and multimodal incident-review case studies to show how one representation layer supports three very different downstream workflows.</li>
</ul>
'@
    }
    'Attention|Transformers|Fusion' {
@'
<div class="label">Deep Dive</div>
<ul>
  <li><strong>Inner workings:</strong> attention scores, token mixing, positional encoding, connector modules, and multimodal fusion pathways.</li>
  <li><strong>Algorithm sketch:</strong> query-key-value computation, residual block flow, connector insertion, and cross-attention versus dual-encoder inference paths.</li>
  <li><strong>Intuition:</strong> attention as learned routing that decides what each token should look at and what context it should ignore.</li>
  <li><strong>Tradeoffs:</strong> dual encoders versus cross-attention, context quality versus memory cost, and modular fusion versus tightly coupled stacks.</li>
  <li><strong>Common failure modes:</strong> context dilution, connector bottlenecks, hallucinated grounding, and long-context degradation.</li>
</ul>
<div class="label">Illustrations and Figures</div>
<ul>
  <li>Token-flow diagrams, attention heatmaps, connector schematics, and side-by-side fusion architecture comparisons.</li>
</ul>
<div class="label">Worked Example</div>
<ul>
  <li>Trace one image-text and one audio-text query through dual-encoder and cross-attention pipelines and compare output behavior and compute cost.</li>
</ul>
<div class="label">Case Study Thread</div>
<ul>
  <li>Show how the same fusion choices change an inspection assistant, a streaming speech copilot, and a multimodal incident-review system.</li>
</ul>
'@
    }
    'Generative Model Families|Image Data|Video Data|Audio Data|Simulation' {
@'
<div class="label">Deep Dive</div>
<ul>
  <li><strong>Inner workings:</strong> core generation mechanism, conditioning path, sampling or decoding loop, and control interfaces used to shape outputs.</li>
  <li><strong>Algorithm sketch:</strong> forward/reverse diffusion or decoding process, control injection, editing loop, and QA handoff into a training-ready dataset.</li>
  <li><strong>Intuition:</strong> why controllable generation is valuable for coverage expansion, rare-case creation, and label-preserving edits.</li>
  <li><strong>Tradeoffs:</strong> realism versus usefulness, controllability versus diversity, and generation speed versus quality or fidelity.</li>
  <li><strong>Common failure modes:</strong> synthetic artifacts, temporal inconsistency, prompt leakage, label drift, shortcut cues, and simulator mismatch.</li>
</ul>
<div class="label">Illustrations and Figures</div>
<ul>
  <li>Pipeline schematics for generation, editing, conditioning, or simulation control; temporal diagrams where time is a first-class variable; and label-flow diagrams from generator to QA.</li>
</ul>
<div class="label">Worked Example</div>
<ul>
  <li>Walk through one end-to-end synthetic-data recipe, show the conditioning inputs, generated outputs, QA gates, and the final training-ready artifact.</li>
</ul>
<div class="label">Case Study Thread</div>
<ul>
  <li>Revisit the recurring industrial defect, multilingual speech, and incident-review projects to show how the synthetic-data engine changes across image, audio, video, and simulation-heavy settings.</li>
</ul>
'@
    }
    'Foundation Models|Document AI|Omni Systems|Retrieval|RAG|Agent Systems' {
@'
<div class="label">Deep Dive</div>
<ul>
  <li><strong>Inner workings:</strong> how foundation models combine perception, grounding, retrieval, and generation, and what remains modular versus unified.</li>
  <li><strong>Algorithm sketch:</strong> retrieval-grounding-generation loops, schema validation paths, and modular tool-calling sequences.</li>
  <li><strong>Intuition:</strong> why a decomposed system often beats a monolithic prompt when evidence quality and traceability matter.</li>
  <li><strong>Tradeoffs:</strong> omni-model simplicity versus modular debuggability, retrieval quality versus latency, and flexibility versus governance control.</li>
  <li><strong>Common failure modes:</strong> retrieval miss, OCR corruption, grounding mismatch, invalid structured output, and brittle tool orchestration.</li>
</ul>
<div class="label">Illustrations and Figures</div>
<ul>
  <li>System architecture diagrams, document or multimodal retrieval pipelines, grounding loops, and modular-vs-omni design comparisons.</li>
</ul>
<div class="label">Worked Example</div>
<ul>
  <li>Assemble a retrieval-grounding-generation workflow with explicit intermediate artifacts, then compare it with a direct omni-model baseline.</li>
</ul>
<div class="label">Case Study Thread</div>
<ul>
  <li>Compare how the recurring case studies use generalist foundation models differently: retrieval-heavy incident review, OCR-like visual evidence, and audio-plus-text operational analytics.</li>
</ul>
'@
    }
    'Fine-Tuning|Inference Engineering|Deployment|Monitoring|Debugging' {
@'
<div class="label">Deep Dive</div>
<ul>
  <li><strong>Inner workings:</strong> what changes during adaptation, what remains frozen, and how serving/runtime choices alter final system behavior.</li>
  <li><strong>Algorithm sketch:</strong> training loop, evaluation loop, regression gate, deployment path, and post-launch feedback loop.</li>
  <li><strong>Intuition:</strong> why optimization, deployment, and monitoring are one connected lifecycle rather than separate engineering chores.</li>
  <li><strong>Tradeoffs:</strong> full tuning versus adapters, quality versus latency, quantization versus fidelity, and modular observability versus platform simplicity.</li>
  <li><strong>Common failure modes:</strong> overfitting to synthetic artifacts, slice regressions, quantization regressions, drift, silent retrieval failures, and broken rollback logic.</li>
</ul>
<div class="label">Illustrations and Figures</div>
<ul>
  <li>Training-to-serving lifecycle diagrams, ablation tables, latency-quality tradeoff charts, and drift or failure-bucket dashboards.</li>
</ul>
<div class="label">Worked Example</div>
<ul>
  <li>Run one training or deployment decision from baseline through evaluation, then show the regression checks or monitoring signals that justify the final choice.</li>
</ul>
<div class="label">Case Study Thread</div>
<ul>
  <li>Track one shared lifecycle across the recurring industrial, speech, and incident-review systems so readers can compare adaptation, serving, and monitoring decisions side by side.</li>
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
<div class="label">Illustrations and Figures</div>
<ul>
  <li>Decision trees, workflow maps, schema diagrams, evaluation matrices, or project-roadmap graphics that make the chapter operational instead of purely verbal.</li>
</ul>
<div class="label">Worked Example</div>
<ul>
  <li>One concrete case-study walkthrough showing how the chapter's framework changes a real modeling or data decision.</li>
</ul>
<div class="label">Case Study Thread</div>
<ul>
  <li>Anchor the chapter in one of the recurring book-long case studies so the framework stays connected to a concrete build and evaluation path.</li>
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

      $coreBlock = Get-CoreBlocks $title
      if ([regex]::IsMatch($article, '<div class="label">Deep Dive</div>.*?(?=<div class="label">Learning Outcomes</div>)', 'Singleline')) {
        $article = [regex]::Replace(
          $article,
          '<div class="label">Deep Dive</div>.*?(?=<div class="label">Learning Outcomes</div>)',
          $coreBlock + "`r`n",
          'Singleline'
        )
      } elseif ($article -match '<div class="label">Learning Outcomes</div>') {
        $article = $article -replace '<div class="label">Learning Outcomes</div>', ($coreBlock + "`r`n<div class=""label"">Learning Outcomes</div>")
      } else {
        $article += "`r`n" + $coreBlock
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
