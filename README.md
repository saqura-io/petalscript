<div align="center">
    <img src="https://s3.moondrop.io/share/2023/06/13/logo.png" alt="Helica" width="600" />
</div>

<div align="center">Grammar and introductory documentation for the PetalScript DSL powering Saqura.io</div>

<br />

<div align="center">
    <a href="https://github.com/xojs/xo">
        <img src="https://img.shields.io/badge/technology-antlr4-d6164c?style=for-the-badge" alt="Code Style: XO">
    </a>
    <a href="https://www.jetbrains.com/help/idea/code-style-kotlin.html">
        <img src="https://img.shields.io/badge/style%20guide-jetbrains-d6164c?style=for-the-badge" alt="Style Guide: JetBrains">
    </a>
    <a href="https://opensource.org/licenses/MIT">
        <img src="https://img.shields.io/badge/license-MIT-d6164c?style=for-the-badge" alt="MIT License">
    </a>
</div>

## About
PetalScript is a domain-specific language designed developed for Saqura.io. PetalScript is designed to simplify complex aggregation of log data and focuses on this domain specifically.

This repository only harbors the grammar and parser declarations, and an introductory documentation to get familiarized with PetalScript. Implementation of the language can be found in the [Hanami repository](https://github.com/saqura-io/hanami).

## Why another DSL?
PetalScript was meticulously crafted to articulate aggregation intentions more effectively than existing solutions such as SQL or Lucene. Throughout its design process, PetalScript was consistently developed to offer developers an experience akin to programming with a full-fledged language. This encompasses the ability to incorporate multiple expressions within a single query, an easily digestible syntax, and enhanced efficiency in achieving comparable results to alternative solutions.

## Available Tooling
Please refer to [petalscript-vscode](https://github.com/saqura-io/petalscript-vscode) for an easy to use Visual Studio Code extension, providing a solid fundamental tooling for working with PetalScript.

## Higher-Order Functions
PetalScript is designed around higher-order function invocations providing functionality.

- `filter` - *Filtering a data set*
- `search` - *Searching within a data set*
- `sort` - *Sorting a data set*
- `count` - *Count of resulting data*
- `sum` - *Summing up resulting data*
- `group` - *Grouping together resulting data*
- `output` - *Printing of a variable*

In addition to higher-order functions, PetalScript provides a generalized aggregation syntax using the array notation (`[]`).

## General Example
A general and straight forward example filtering for logs in an NGINX loadbalancer microservices:

```
let crashLogs = filter(from: "nginx_loadbalancer", by: "loglevel", equals: "error");
let microservice = filter(from: "auth_microservice", by: "date", equals: "yesterday");

let results = [crashLogs, microservice];

output(as: "json", results);
```

## DSL Specification Examples
This section encompasses examples for each higher-order function available in the current iteration of PetalScript.

### `filter` - Filtering a data set
`from` property may be any string. `by` property may be any string. `equals` property may be any string.

```
let filterExample = filter(from: "application1", by: "loglevel", equals: "error");
let filterExample2 = filter(from: "application2", by: "loglevel", equals: "error");
```

### `search` - Searching within a data set
`in` property may be any string or a variable. `for` property may be any string. `caseInsensitive` is optional and may be true or false. `exactMatch` property is optional and may be true or false.
```
let searchExampleSimple = search(in: "application1", for: "invalid request");
let searchExampleCase = search(in: "application1", for: "invalid request", caseInsensitive: true);
let searchExampleExact = search(in: "application1", for: "invalid request", exactMatch: true);
let searchExampleCombined = search(in: "application1", for: "invalid request", caseInsensitive: true, exactMatch: true);
let searchExampleReuseVariable = search(in: filterExample, for: "user registered", caseInsensitive: true);
```

### `sort` - Sorting a data set
`from` property may be any string or a variable. `by` property may be any string. `order` property may be `desc` or `asc`.

```
let sortExampleAsc = sort(from: "application1", by: "timestamp", order: "asc");
let sortExampleDesc = sort(from: "application1", by: "timestamp", order: "desc");

# Advanced sort using prior variable as input.
let sortReuse = sort(from: searchExampleReuseVariable, by: "timestamp", order: "desc");
```

### `count` - Sorting a data set
`from` property may be any string or a variable. `by` property may be any string.

```
let countByLogLevel = count(from: "application1", by: "loglevel");

# Advanced count example using prior variable as input.
let countReuse = count(from: sortReuse, by: "loglevel");
```

### `sum` - Summing up resulting data
`from` property may be any string or a variable. `by` property may be any string.

```
let sumByResponseTime = sum(from: "application1", by: "responsetime");

# Advanced sum example using prior variable as input.
let advSumByRT = sum(from: filterExample2, by: "responsetime");
```

### `[]` - Aggregating logs
Array notation may never be empty: `0 < [] Length <= Available Variables`

```
let aggregatedLogs = [filterExample2, sortReuse];
```

### `output` - Printing of a variable
`as` property may be: `json` or `yaml` or `plain`

```
output(as: "json", aggregatedLogs);
```

## License
This repository makes use of the [MIT License](https://opensource.org/licenses/MIT) and all of its correlating traits.
