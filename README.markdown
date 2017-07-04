# Alfa Bank Automation Testing Framework
This is the testing framework for [AlfaBank](http://www.alfabank.com) project wrote with Cucumber and Capybara frameworks on Ruby

## Usage
To launch this project you should firstly install Ruby and run 

```bash
$ bundle install
```

## Available option

### 1. Run all tests with default config (no parallel)

```bash
$ cucumber
```

By default HTML-report will be generated to *features_report.html* file

### 2. Run several tests:

```bash
$ cucumber  features/test1.feature, features/test2.feature
```

### 3. Run tests in parallel:

By default tests will run at 4 threads. Several HTML-reports will be generated at *report\[report_number\].html* file

```bash
$ parallel_cucumber features
```

To run several tests, call 

```bash
$ parallel_cucumber features/test1.feature, features/test2.feature
```

Set up threads number

```bash
$ parallel_cucumber features -n 8
```

Get more info about parallel_cucumber with 

```bash
$ parallel_cucumber --help
```
