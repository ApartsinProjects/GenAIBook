$ErrorActionPreference = "Stop"

$repo = "E:\Projects\GenAIBook"

function Read-Text([string]$path) {
  return [System.IO.File]::ReadAllText($path)
}

function Write-Text([string]$path, [string]$content) {
  $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
  [System.IO.File]::WriteAllText($path, $content, $utf8NoBom)
}

function Replace-Or-Fail([string]$content, [string]$oldValue, [string]$newValue, [string]$label) {
  if (-not $content.Contains($oldValue)) {
    throw "Could not find expected block for $label"
  }
  return $content.Replace($oldValue, $newValue)
}

function Regex-Replace-Or-Fail([string]$content, [string]$pattern, [string]$replacement, [string]$label) {
  $updated = [regex]::Replace($content, $pattern, $replacement, 1)
  if ($updated -eq $content) {
    throw "Could not find expected pattern for $label"
  }
  return $updated
}

$indexPath = Join-Path $repo "index.html"
$bookTocPath = Join-Path $repo "book-toc.html"
$frontPath = Join-Path $repo "front-matter\index.html"
$appendixPath = Join-Path $repo "appendices\index.html"

$index = Read-Text $indexPath
$bookToc = Read-Text $bookTocPath
$front = Read-Text $frontPath
$appendix = Read-Text $appendixPath

$adoptionOld = @'
    <section class="panel">
      <h2>Adoption Paths</h2>
      <ul class="summary">
        <li><strong>12-Week Course Maps:</strong><br/><a class="inline-link" href="course-pathways.html">Open undergraduate and graduate course pathways</a></li>
      </ul>
    </section>
'@

$adoptionNew = @'
    <section class="panel">
      <h2>Adoption Paths</h2>
      <ul class="summary">
        <li><strong>12-Week Course Maps:</strong><br/><a class="inline-link" href="course-pathways.html">Open undergraduate and graduate course pathways</a></li>
        <li><strong>Dependency Graph:</strong><br/><a class="inline-link" href="dependency-graph.html">Open chapter dependencies and prerequisite routes</a></li>
      </ul>
    </section>
'@

$frontAssetsOld = @'
  <div class="label">Practical Assets</div>
  <ul class="chapter-list">
    <li>Reader-path guide, dependency logic, and course-adoption framing</li>
    <li>Case-study spine for industrial inspection, multilingual speech analytics, and multimodal incident review</li>
    <li><a class="inline-link" href="course-pathways.html">Four 12-week suggested course syllabuses</a></li>
  </ul>
'@

$frontAssetsNew = @'
  <div class="label">Practical Assets</div>
  <ul class="chapter-list">
    <li>Reader-path guide, dependency logic, and course-adoption framing</li>
    <li>Case-study spine for industrial inspection, multilingual speech analytics, and multimodal incident review</li>
    <li><a class="inline-link" href="course-pathways.html">Four 12-week suggested course syllabuses</a></li>
    <li><a class="inline-link" href="dependency-graph.html">Dependency graph for self-study and course planning</a></li>
  </ul>
'@

$appendixCardOld = @'
  <div class="label">Chapter Map</div>
  <ol class="chapter-list">
    <li><strong>A</strong> Basic Mathematics Refresher <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span></li>
<li><strong>B</strong> PyTorch Tutorial and Workflow Primer <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span></li>
<li><strong>C</strong> Installation Instructions and Local Environment Setup <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span></li>
<li><strong>D</strong> Provisioning Cloud Models and Hosted Infrastructure <span class="tag">Advanced</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>E</strong> Audio Companion and Modular Learning Guide <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
  </ol>
'@

$appendixCardNew = @'
  <div class="label">Chapter Map</div>
  <ol class="chapter-list">
    <li><strong>A</strong> Basic Mathematics Refresher <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span></li>
<li><strong>B</strong> PyTorch Tutorial and Workflow Primer <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span></li>
<li><strong>C</strong> Installation Instructions and Local Environment Setup <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span></li>
<li><strong>D</strong> Provisioning Cloud Models and Hosted Infrastructure <span class="tag">Advanced</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>E</strong> Audio Companion and Modular Learning Guide <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>F</strong> Research Methods Companion Appendix <span class="tag">Core</span> <span class="tag">Graduate</span> <span class="tag">Research</span></li>
  </ol>
'@

$tagsMap = @{
  "part1" = @'
  <ol class="chapter-list">
    <li><strong>01</strong> What This Book Will Let You Build <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>02</strong> A Complete Synthetic-Data Pipeline in Miniature <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>03</strong> Task Taxonomy and Success Criteria <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>04</strong> The Modern Toolbox Without the Noise <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
  </ol>
'@
  "part2" = @'
  <ol class="chapter-list">
    <li><strong>05</strong> Data Rights, Provenance, and Responsible Acquisition <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>06</strong> Dataset Design, Schemas, and Versioning <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>07</strong> Annotation Systems, Weak Supervision, and Auto-Labeling <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>08</strong> Baselines, Ablations, and Credible Claims <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
  </ol>
'@
  "part3" = @'
  <ol class="chapter-list">
    <li><strong>09</strong> Embeddings, Self-Supervision, and Shared Representation Spaces <span class="tag">Advanced</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>10</strong> Attention, Transformers, and Multimodal Fusion <span class="tag">Advanced</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>11</strong> Generative Model Families for Image, Audio, and Video <span class="tag">Advanced</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>12</strong> Foundation Models, Document AI, and Omni Systems in Practice <span class="tag">Advanced</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>13</strong> Pre-Deployment Debugging for Modern Multimodal Models <span class="tag">Advanced</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
  </ol>
'@
  "part4" = @'
  <ol class="chapter-list">
    <li><strong>14</strong> Designing the Synthetic Data Engine <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>15</strong> Image Data: Generation, Editing, and Repurposing <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>16</strong> Video Data: Temporal Labels, Tracks, and Synthetic Clips <span class="tag">Advanced</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>17</strong> Audio Data: Speech, Events, TTS, Diarization, and Voice Transformation <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>18</strong> Simulation, Procedural Data, and Real-to-Sim-to-Real Pipelines <span class="tag">Advanced</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>19</strong> Synthetic Data Operations: QA, Filtering, Reward Models, and Judge Loops <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>20</strong> Synthetic Data for Training, Evaluation, Stress Testing, and Challenge Sets <span class="tag">Advanced</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
  </ol>
'@
  "part5" = @'
  <ol class="chapter-list">
    <li><strong>21</strong> Fine-Tuning Vision and Video Models <span class="tag">Advanced</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>22</strong> Fine-Tuning Audio Models and Streaming Speech Systems <span class="tag">Advanced</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>23</strong> Building Multimodal Retrieval, RAG, and Agent Systems <span class="tag">Advanced</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>24</strong> Inference Engineering, Deployment, and Cost Control <span class="tag">Advanced</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>25</strong> Monitoring, Drift, and Failure Analysis in the Wild <span class="tag">Advanced</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
  </ol>
'@
  "part6" = @'
  <ol class="chapter-list">
    <li><strong>26</strong> Application Blueprint: Industrial Inspection and Manufacturing <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>27</strong> Application Blueprint: Speech, Audio Analytics, and Voice Systems <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>28</strong> Application Blueprint: Robotics, Accessibility, and Multimodal Incident Systems <span class="tag">Advanced</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>29</strong> Research Frontiers and Open Questions <span class="tag">Advanced</span> <span class="tag">Graduate</span> <span class="tag">Research</span></li>
<li><strong>30</strong> Anti-Patterns, Failed Designs, and When Not to Use Synthetic Data <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>31</strong> Capstones, Replication Studies, and Paper-Style Contributions <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
<li><strong>32</strong> Teaching Studios, Assessment Design, and Course Reuse <span class="tag">Core</span> <span class="tag">Undergrad</span> <span class="tag">Graduate</span> <span class="tag">Eng</span> <span class="tag">Research</span></li>
  </ol>
'@
}

foreach ($pageVar in @("index","bookToc")) {
  $content = Get-Variable -Name $pageVar -ValueOnly
  $content = Regex-Replace-Or-Fail $content '(?s)<section class="panel">\s*<h2>Adoption Paths</h2>.*?</section>' $adoptionNew "$pageVar adoption panel"
  $content = Regex-Replace-Or-Fail $content '(?s)<div class="label">Practical Assets</div>\s*<ul class="chapter-list">\s*<li>.*?course-pathways\.html.*?</ul>' $frontAssetsNew "$pageVar front assets"
  $content = Regex-Replace-Or-Fail $content '(?s)<section class="section-card" id="appendix">.*?<div class="label">Chapter Map</div>\s*<ol class="chapter-list">.*?</ol>' ('<section class="section-card" id="appendix">' + "`r`n  <div class=""part-label"">Appendices</div>`r`n  <h2>Reference, Setup, and Onboarding</h2>`r`n  <p>The appendices keep the main text focused while still supporting readers who need review material, environment guidance, or cloud provisioning help.</p>`r`n" + $appendixCardNew.Trim()) "$pageVar appendix card"

  foreach ($key in $tagsMap.Keys) {
    $sectionId = $key -replace "part", "part"
    $pattern = "(?s)(<section class=""section-card"" id=""$sectionId"">.*?<div class=""label"">Chapter Map</div>\s*)(<ol class=""chapter-list"">.*?</ol>)"
    $replacement = '$1' + $tagsMap[$key]
    $updated = [regex]::Replace($content, $pattern, $replacement, 1)
    if ($updated -eq $content) {
      throw "Could not update $key chapter map in $pageVar"
    }
    $content = $updated
  }

  Set-Variable -Name $pageVar -Value $content
}

$front = Replace-Or-Fail $front '<a class="inline-link" href="../book-toc.html">Alternate High-Level TOC URL</a>' "<a class=""inline-link"" href=""../book-toc.html"">Alternate High-Level TOC URL</a>`r`n<a class=""inline-link"" href=""../dependency-graph.html"">Open Dependency Graph</a>" "front matter nav"
$front = Replace-Or-Fail $front '<li><a class="inline-link" href="../course-pathways.html">Open the full Suggested Course Syllabuses page</a> with four 12-week course maps and book-layout recommendations.</li>' '<li><a class="inline-link" href="../course-pathways.html">Open the full Suggested Course Syllabuses page</a> with four 12-week course maps and book-layout recommendations.</li>' + "`r`n  <li><a class=""inline-link"" href=""../dependency-graph.html"">Open the dependency graph page</a> to see which chapters are core, advanced, and best matched to each course path.</li>" "FM3 dependency link"
$front = Replace-Or-Fail $front '<li>Reading guides, project journals, experiment trackers, slide decks, assessment templates, and dependency maps.</li>' '<li>Reading guides, project journals, experiment trackers, slide decks, assessment templates, and dependency maps.</li>' + "`r`n<li><a class=""inline-link"" href=""../dependency-graph.html"">Dependency graph page</a> for self-study and semester planning.</li>" "FM2 dependency asset"

$appendix = Replace-Or-Fail $appendix '<li><a href="#audio-companion-and-modular-learning-guide">E - Audio Companion and Modular Learning Guide</a></li>' "<li><a href=""#audio-companion-and-modular-learning-guide"">E - Audio Companion and Modular Learning Guide</a></li>`r`n<li><a href=""#research-methods-companion-appendix"">F - Research Methods Companion Appendix</a></li>" "appendix jump list"
$appendix = Replace-Or-Fail $appendix '<p class="part-intro">The appendices keep the main text focused while still supporting readers who need review material, environment guidance, or cloud provisioning help.</p>' '<p class="part-intro">The appendices keep the main text focused while still supporting readers who need review material, environment guidance, cloud provisioning help, or a stronger research-methods scaffold for semester projects and paper-style work.</p>' "appendix intro"

$appendixInsertAfter = @'
</article>
</section>
'@

$appendixNewArticle = @'
</article>
<article class="chapter">
<div class="chapter-no">F</div>
<div>
<h3><span id="research-methods-companion-appendix">Research Methods Companion Appendix</span></h3>
<p class="chapter-desc">A compact research-methods appendix that turns the book into a stronger base for seminar projects, capstones, replication studies, and workshop-style papers.</p>
<div class="meta">
<span class="tag">Core</span>
<span class="tag">Graduate</span>
<span class="tag">Research</span>
</div>
<div class="label">Detailed Sections</div>
<ol>
<li>How to turn a build question into a research question with a measurable claim.</li>
<li>Experimental design for real-only, synthetic-only, repurposed, and hybrid comparisons.</li>
<li>Ablations, controls, hidden slices, challenge sets, contamination checks, and memorization audits.</li>
<li>Reporting standards: tables, figures, error buckets, caveats, and reproducibility packages.</li>
<li>How to turn the recurring case studies into semester papers, replication studies, or workshop submissions.</li>
</ol>
<div class="label">Deep Dive</div>
<ul>
<li>Why research-method discipline changes the meaning of results in synthetic-data-heavy systems.</li>
<li>How weak baselines, poor split design, and underpowered ablations make otherwise promising projects unconvincing.</li>
</ul>
<div class="label">Illustrations and Figures</div>
<ul>
<li>Claim-to-experiment maps, ablation tables, evaluation ladders, paper-outline templates, and failure-analysis figures.</li>
</ul>
<div class="label">Worked Example</div>
<ul>
<li>Convert one multilingual speech or inspection project from a course prototype into a paper-style experiment plan with baselines, slices, and reporting templates.</li>
</ul>
<div class="label">Case Study Thread</div>
<ul>
<li>Shows how the industrial inspection, multilingual speech analytics, and multimodal incident-review cases can all be reframed as publishable semester projects.</li>
</ul>
<div class="label">Learning Outcomes</div>
<ul><li>Design credible experiments around synthetic-data interventions.</li><li>Write cleaner claims, ablations, and limitations sections.</li><li>Turn capstone work into a stronger paper-style package.</li></ul>
<div class="label">Key Tools, Libraries, and Models</div>
<ul><li>Experiment trackers, paper templates, ablation planners, contamination-audit checklists, and reproducibility manifests.</li></ul>
<div class="label">Representative Benchmarks and Datasets</div>
<ul><li>Hidden-slice evaluation sets, challenge sets, held-out real data, and paper-ready benchmark tables.</li></ul>
<div class="label">Suggested Notebooks and Demos</div>
<ul><li><code>F_research-methods-companion.ipynb</code>, <code>F_ablation-and-reporting-demo</code></li></ul>
</div>
</article>
</section>
'@

$appendix = Regex-Replace-Or-Fail $appendix '(?s)</article>\s*</section>' $appendixNewArticle "appendix F insertion"

Write-Text $indexPath $index
Write-Text $bookTocPath $bookToc
Write-Text $frontPath $front
Write-Text $appendixPath $appendix
