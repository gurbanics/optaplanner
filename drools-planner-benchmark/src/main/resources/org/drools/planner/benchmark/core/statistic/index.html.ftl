<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Planner benchmark report ${plannerStatistic.plannerBenchmark.startingTimestamp?datetime}</title>
    <link href="twitterbootstrap/css/bootstrap.css" rel="stylesheet">
    <link href="twitterbootstrap/css/bootstrap-responsive.css" rel="stylesheet">
    <link href="website/css/benchmarkReport.css" rel="stylesheet">
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
</head>
<body>

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span2">
            <div class="benchmark-report-nav"
                <a href="http://www.jboss.org/drools/drools-planner"><img src="website/img/droolsPlannerLogo.png" alt="Drools Planner"/></a>
                <ul class="nav nav-list">
                    <li><a href="#summary">Summary</a></li>
                    <li>
                        <ul class="nav nav-list">
                            <li><a href="#summary_bestScore">Best score</a></li>
                            <li><a href="#summary_winningScoreDifference">Winning score difference</a></li>
                            <li><a href="#summary_timeSpend">Time spend</a></li>
                            <li><a href="#summary_scalability">Scalability</a></li>
                            <li><a href="#summary_averageCalculateCount">Average calculate count</a></li>
                        </ul>
                    </li>
                    <li class="divider"></li>
                <#list plannerStatistic.plannerBenchmark.unifiedProblemBenchmarkList as problemBenchmark>
                    <li><a href="#problem_${problemBenchmark.name}">${problemBenchmark.name}</a></li>
                </#list>
                    <li class="divider"></li>
                    <li><a href="#benchmarkInformation">Benchmark information</a></li>
                </ul>
            </div>
        </div>
        <div class="span10">
            <header class="main-page-header">
                <h1>Benchmark report</h1>
            </header>
            <section id="summary">
                <div class="page-header">
                    <h1>Summary</h1>
                </div>
            <#if plannerStatistic.plannerBenchmark.hasAnyFailure()>
                <div class="alert alert-error">
                    <p>${plannerStatistic.plannerBenchmark.failureCount} benchmarks have failed!</p>
                </div>
            </#if>

                <section id="summary_bestScore">
                    <h2>Best score summary</h2>
                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            <li class="active">
                                <a href="#summary_bestScore_chart" data-toggle="tab">Chart</a>
                            </li>
                            <li>
                                <a href="#summary_bestScore_table" data-toggle="tab">Table</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="summary_bestScore_chart">
                                <img src="${plannerStatistic.bestScoreSummaryFile.name}"/>
                            </div>
                            <div class="tab-pane" id="summary_bestScore_table">
                                <table class="table table-striped table-bordered">
                                    <tr>
                                        <th>Solver</th>
                                    <#list plannerStatistic.plannerBenchmark.unifiedProblemBenchmarkList as problemBenchmark>
                                        <th>${problemBenchmark.name}</th>
                                    </#list>
                                        <th>Average</th>
                                        <th>Ranking</th>
                                    </tr>
                                <#list plannerStatistic.plannerBenchmark.solverBenchmarkList as solverBenchmark>
                                    <tr<#if solverBenchmark.rankingBest> class="rankingBest"</#if>>
                                        <th>${solverBenchmark.name}</th>
                                        <#list plannerStatistic.plannerBenchmark.unifiedProblemBenchmarkList as problemBenchmark>
                                            <#assign singleBenchmark = solverBenchmark.findSingleBenchmark(problemBenchmark)>
                                            <#if !singleBenchmark??>
                                                <td></td>
                                            <#elseif !singleBenchmark.success>
                                                <td><span class="label warning">Failed</span></td>
                                            <#else>
                                                <td>${singleBenchmark.score}</td>
                                            </#if>
                                        </#list>
                                        <#if !solverBenchmark.averageScore??>
                                            <td></td>
                                        <#else>
                                            <td>${solverBenchmark.averageScore}</td>
                                        </#if>
                                        <#if !solverBenchmark.ranking??>
                                            <td></td>
                                        <#elseif solverBenchmark.rankingBest>
                                            <td><span class="badge badge-success">${solverBenchmark.ranking}</span></td>
                                        <#else>
                                            <td><span class="badge">${solverBenchmark.ranking}</span></td>
                                        </#if>
                                    </tr>
                                </#list>
                                </table>
                            </div>
                        </div>
                    </div>
                </section>

                <section id="summary_winningScoreDifference">
                    <h2>Winning score difference summary chart</h2>
                    <img src="${plannerStatistic.winningScoreDifferenceSummaryFile.name}"/>
                </section>

                <section id="summary_timeSpend">
                    <h2>Time spend summary chart</h2>
                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            <li class="active">
                                <a href="#summary_timeSpend_chart" data-toggle="tab">Chart</a>
                            </li>
                            <li>
                                <a href="#summary_timeSpend_table" data-toggle="tab">Table</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="summary_timeSpend_chart">
                                <img src="${plannerStatistic.timeSpendSummaryFile.name}"/>
                            </div>
                            <div class="tab-pane" id="summary_timeSpend_table">
                                <table class="table table-striped table-bordered">
                                    <tr>
                                        <th>Solver</th>
                                    <#list plannerStatistic.plannerBenchmark.unifiedProblemBenchmarkList as problemBenchmark>
                                        <th>${problemBenchmark.name}</th>
                                    </#list>
                                    </tr>
                                <#list plannerStatistic.plannerBenchmark.solverBenchmarkList as solverBenchmark>
                                    <tr<#if solverBenchmark.rankingBest> class="rankingBest"</#if>>
                                        <th>${solverBenchmark.name}</th>
                                        <#list plannerStatistic.plannerBenchmark.unifiedProblemBenchmarkList as problemBenchmark>
                                            <#assign singleBenchmark = solverBenchmark.findSingleBenchmark(problemBenchmark)>
                                            <#if !singleBenchmark??>
                                                <td></td>
                                            <#elseif !singleBenchmark.success>
                                                <td><span class="label warning">Failed</span></td>
                                            <#else>
                                                <td>${singleBenchmark.timeMillisSpend} ms</td>
                                            </#if>
                                        </#list>
                                    </tr>
                                </#list>
                                </table>
                            </div>
                        </div>
                    </div>
                </section>

                <section id="summary_scalability">
                    <h2>Scalability summary chart</h2>
                    <img src="${plannerStatistic.scalabilitySummaryFile.name}"/>
                </section>

                <section id="summary_averageCalculateCount">
                    <h2>Average calculate count summary</h2>
                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            <li class="active">
                                <a href="#summary_averageCalculateCount_chart" data-toggle="tab">Chart</a>
                            </li>
                            <li>
                                <a href="#summary_averageCalculateCount_table" data-toggle="tab">Table</a>
                            </li>
                        </ul>
                        <div class="tab-content">
                            <div class="tab-pane active" id="summary_averageCalculateCount_chart">
                                <img src="${plannerStatistic.averageCalculateCountSummaryFile.name}"/>
                            </div>
                            <div class="tab-pane" id="summary_averageCalculateCount_table">
                                <table class="table table-striped table-bordered">
                                    <tr>
                                        <th>Solver</th>
                                    <#list plannerStatistic.plannerBenchmark.unifiedProblemBenchmarkList as problemBenchmark>
                                        <th>${problemBenchmark.name}</th>
                                    </#list>
                                    </tr>
                                <#list plannerStatistic.plannerBenchmark.solverBenchmarkList as solverBenchmark>
                                    <tr<#if solverBenchmark.rankingBest> class="rankingBest"</#if>>
                                        <th>${solverBenchmark.name}</th>
                                        <#list plannerStatistic.plannerBenchmark.unifiedProblemBenchmarkList as problemBenchmark>
                                            <#assign singleBenchmark = solverBenchmark.findSingleBenchmark(problemBenchmark)>
                                            <#if !singleBenchmark??>
                                                <td></td>
                                            <#elseif !singleBenchmark.success>
                                                <td><span class="label warning">Failed</span></td>
                                            <#else>
                                                <td>${singleBenchmark.averageCalculateCountPerSecond}/sec</td>
                                            </#if>
                                        </#list>
                                    </tr>
                                </#list>
                                </table>
                            </div>
                        </div>
                    </div>
                </section>
            </section>

            <h1>Solver benchmarks</h1>
            <p>TODO</p>

            <div class="page-header">
                <h1>Problem benchmarks</h1>
            </div>
        <#list plannerStatistic.plannerBenchmark.unifiedProblemBenchmarkList as problemBenchmark>
            <section id="problem_${problemBenchmark.name}">
                <h2>${problemBenchmark.name}</h2>
                <#if problemBenchmark.hasAnyFailure()>
                    <div class="alert alert-error">
                        <p>${problemBenchmark.failureCount} benchmarks have failed!</p>
                    </div>
                </#if>
                <#if problemBenchmark.hasAnySuccess() && problemBenchmark.hasAnyProblemStatistic()>
                    <div class="tabbable">
                        <ul class="nav nav-tabs">
                            <#assign firstRow = true>
                            <#list problemBenchmark.problemStatisticList as problemStatistic>
                                <li<#if firstRow> class="active"</#if>>
                                    <a href="#problemStatistic_${problemStatistic.anchorId}" data-toggle="tab">${problemStatistic.problemStatisticType}</a>
                                </li>
                                <#assign firstRow = false>
                            </#list>
                        </ul>
                        <div class="tab-content">
                            <#assign firstRow = true>
                            <#list problemBenchmark.problemStatisticList as problemStatistic>
                                <div class="tab-pane<#if firstRow> active</#if>" id="problemStatistic_${problemStatistic.anchorId}">
                                    <div class="btn-group">
                                        <button class="btn" onclick="window.location.href='${problemStatistic.csvFilePath}'"><i class="icon-download"></i> CVS file</button>
                                    </div>
                                    <img src="${problemStatistic.graphFilePath}"/>
                                </div>
                                <#assign firstRow = false>
                            </#list>
                        </div>
                    </div>
                </#if>
            </section>
        </#list>
            <section id="benchmarkInformation">
                <div class="page-header">
                    <h1>Benchmark information</h1>
                </div>
                <table class="table table-striped">
                    <tr>
                        <th>startingTimestamp</th>
                        <td>${plannerStatistic.plannerBenchmark.startingTimestamp?datetime}</td>
                    </tr>
                    <tr>
                        <th>parallelBenchmarkCount</th>
                        <td>${plannerStatistic.plannerBenchmark.parallelBenchmarkCount}</td>
                    </tr>
                    <tr>
                        <th>warmUpTimeMillisSpend</th>
                        <td>${plannerStatistic.plannerBenchmark.warmUpTimeMillisSpend}</td>
                    </tr>
                    <tr>
                        <th>failureCount</th>
                        <td>${plannerStatistic.plannerBenchmark.failureCount}</td>
                    </tr>
                    <tr>
                        <th>plannerVersion</th>
                        <td>${plannerStatistic.plannerBenchmark.plannerVersion!"Unjarred development snapshot"}</td>
                    </tr>
                </table>
            </section>
        </div>
    </div>
</div>

<script src="twitterbootstrap/js/jquery.js"></script>
<script src="twitterbootstrap/js/bootstrap.js"></script>
</body>
</html>