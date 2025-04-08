# cfn-guard-granular-gh-action
Inspired by **guard-action** authored by __grolston__

**Granular CloudFormation Template Validation using AWS cfn-guard**  
Validate your CloudFormation templates with custom `.guard` rules via GitHub Actions.

![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)

## 📦 About

This GitHub Action enables developers to validate CloudFormation templates against custom [cfn-guard](https://github.com/aws-cloudformation/cloudformation-guard) rules. It supports downloading rules from a public URL and allows fine-tuned control over validation output.

## 🚀 Inputs

| Name               | Description                                                                 | Required | Default               |
|--------------------|-----------------------------------------------------------------------------|----------|------------------------|
| `data_directory`   | Path to the CloudFormation templates directory                              | ✅       | –                      |
| `rule_set_url`     | URL to a single `.guard` file hosted on GitHub or elsewhere                 | ✅       | –                      |
| `show_summary`     | Level of summary shown (`all`, `pass`, `fail`, `skip`, `none`)              | ❌       | `fail`                 |
| `output_format`    | Output format: `json`, `yaml`, or `single-line-summary`                     | ❌       | `single-line-summary` |

## 📂 Example Usage

```yaml
name: Validate CloudFormation Templates

on:
  push:
    paths:
      - 'templates/**'

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repo
        uses: actions/checkout@v3

      - name: Validate CFN templates with cfn-guard
        uses: indradey/cfn-guard-granular-gh-action@v1
        with:
          data_directory: './templates'
          rule_set_url: 'https://raw.githubusercontent.com/your-org/rules-repo/main/custom.guard'
          show_summary: 'all'
          output_format: 'json'
## 🧱 Implementation Details

This action:
- Runs in a Docker container based on `ubuntu:latest`
- Downloads and installs the latest version of `cfn-guard`
- Downloads the `.guard` rule file from the given URL
- Executes `cfn-guard validate` with the specified options

## 📜 License

This project is licensed under the [MIT License](LICENSE).

## 👤 Author

**QuantumNeuralCoder**  
Contributions and improvements are welcome. Feel free to open issues or pull requests!
