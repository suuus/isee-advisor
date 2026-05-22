# csvtool

A CLI tool for transforming and filtering CSV files.

## What it does

- Filter rows by column value
- Rename columns
- Convert CSV to JSON or TSV
- Merge multiple CSV files by a key column

## Usage

```
csvtool filter --col status --value active input.csv
csvtool rename --map "old_name:new_name" input.csv
csvtool convert --format json input.csv
csvtool merge --key id file1.csv file2.csv
```

## Install

```
npm install -g csvtool
```

## Why we built this

Existing tools were either too complex or didn't handle large files gracefully. This does one thing and does it well.
