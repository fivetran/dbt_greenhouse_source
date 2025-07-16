# Greenhouse Source dbt Package ([Docs](https://fivetran.github.io/dbt_greenhouse_source/))

<p align="left">
    <a alt="License"
        href="https://github.com/fivetran/dbt_greenhouse_source/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/License-Apache%202.0-blue.svg" /></a>
    <a alt="dbt-core">
        <img src="https://img.shields.io/badge/dbt_Core™_version->=1.3.0_,<2.0.0-orange.svg" /></a>
    <a alt="Maintained?">
        <img src="https://img.shields.io/badge/Maintained%3F-yes-green.svg" /></a>
    <a alt="PRs">
        <img src="https://img.shields.io/badge/Contributions-welcome-blueviolet" /></a>
    <a alt="Fivetran Quickstart Compatible"
        href="https://fivetran.com/docs/transformations/dbt/quickstart">
        <img src="https://img.shields.io/badge/Fivetran_Quickstart_Compatible%3F-yes-green.svg" /></a>
</p>

## What does this dbt package do?
- Materializes [Greenhouse staging tables](https://fivetran.github.io/dbt_greenhouse_source/#!/overview/greenhouse_source/models/?g_v=1) which leverage data in the format described by [this ERD](https://fivetran.com/docs/applications/greenhouse/#schemainformation). These staging tables clean, test, and prepare your Greenhouse data from [Fivetran's connector](https://fivetran.com/docs/applications/greenhouse) for analysis by doing the following:
  - Name columns for consistency across all packages and for easier analysis
  - Adds freshness tests to source data. dbt Core >= 1.9.6 is required to run freshness tests out of the box.
  - Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
- Generates a comprehensive data dictionary of your Greenhouse data through the [dbt docs site](https://fivetran.github.io/dbt_greenhouse_source/).
- These tables are designed to work simultaneously with our [Greenhouse transformation package](https://github.com/fivetran/dbt_greenhouse).

## How do I use the dbt package?
### Step 1: Prerequisites
To use this dbt package, you must have the following:
- At least one Fivetran Greenhouse connection syncing data into your destination.
- A **BigQuery**, **Snowflake**, **Redshift**, **PostgreSQL**, or **Databricks** destination.

### Step 2: Install the package (skip if also using the `greenhouse` transformation package)
Include the following greenhouse_source package version in your `packages.yml` file.
> TIP: Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

```yaml
packages:
  - package: fivetran/greenhouse_source
    version: [">=0.9.0", "<0.10.0"] # we recommend using ranges to capture non-breaking changes automatically
```

### Step 3: Define database and schema variables
By default, this package runs using your destination and the `greenhouse` schema. If this is not where your Greenhouse data is (for example, if your Greenhouse schema is named `greenhouse_fivetran`), add the following configuration to your root `dbt_project.yml` file:

```yml
vars:
    greenhouse_database: your_database_name
    greenhouse_schema: your_schema_name 
```

### Step 4: Disable models for non-existent sources
Your Greenhouse connection might not sync every table that this package expects. If your syncs exclude certain tables, it is because you either do not use that functionality in Greenhouse or have actively excluded some tables from your syncs.

To disable the corresponding functionality in the package, you must set the relevant config variables to `false`. By default, all variables are set to `true`. Alter variables only for the tables you want to disable:

```yml
vars:
    greenhouse_using_prospects: false # Disable if you do not use prospects and/or do not have the PROPECT_POOL and PROSPECT_STAGE tables synced
    greenhouse_using_eeoc: false # Disable if you do not have EEOC data synced and/or do not want to integrate it into the package models
    greenhouse_using_app_history: false # Disable if you do not have APPLICATION_HISTORY synced and/or do not want to run the application_history transform model
    greenhouse_using_job_office: false # Disable if you do not have JOB_OFFICE and/or OFFICE synced, or do not want to include offices in the job_enhanced transform model
    greenhouse_using_job_department: false # Disable if you do not have JOB_DEPARTMENT and/or DEPARTMENT synced, or do not want to include offices in the job_enhanced transform model
```

### (Optional) Step 5: Additional configurations
<details><summary>Expand to view configurations</summary>

#### Passthrough Custom Columns
The Greenhouse `APPLICATION`, `JOB`, and `CANDIDATE` tables may have custom columns, all prefixed with `custom_field_`. To pass these columns along to the staging and final transformation models, add the following variables to your `dbt_project.yml` file:

```yml
vars:
    greenhouse_application_custom_columns: ['the', 'list', 'of', 'columns'] # these columns will be in the final application_enhanced model
    greenhouse_candidate_custom_columns: ['the', 'list', 'of', 'columns'] # these columns will be in the final application_enhanced model
    greenhouse_job_custom_columns: ['the', 'list', 'of', 'columns'] # these columns will be in the final job_enhanced model
```
#### Changing the Build Schema
By default this package will build the Greenhouse Source staging models within a schema titled (<target_schema> + `_greenhouse`). If this is not where you would like your staging models to be written to, add the following configuration to your `dbt_project.yml` file:

```yml
models:
    greenhouse_source:
        +schema: my_new_staging_models_schema # leave blank for just the target_schema
```

#### Change the source table references
If an individual source table has a different name than the package expects, add the table name as it appears in your destination to the respective variable:
> IMPORTANT: See this project's [`dbt_project.yml`](https://github.com/fivetran/dbt_greenhouse_source/blob/main/dbt_project.yml) variable declarations to see the expected names.

```yml
vars:
    greenhouse_<default_source_table_name>_identifier: your_table_name 
```
</details>

### (Optional) Step 6: Orchestrate your models with Fivetran Transformations for dbt Core™
<details><summary>Expand to view details</summary>
<br>

Fivetran offers the ability for you to orchestrate your dbt project through [Fivetran Transformations for dbt Core™](https://fivetran.com/docs/transformations/dbt). Learn how to set up your project for orchestration through Fivetran in our [Transformations for dbt Core™ setup guides](https://fivetran.com/docs/transformations/dbt#setupguide).
</details>

## Does this package have dependencies?
This dbt package is dependent on the following dbt packages. These dependencies are installed by default within this package. For more information on the following packages, refer to the [dbt hub](https://hub.getdbt.com/) site.
> IMPORTANT: If you have any of these dependent packages in your own `packages.yml` file, we highly recommend that you remove them from your root `packages.yml` to avoid package version conflicts.

```yml
packages:
    - package: fivetran/fivetran_utils
      version: [">=0.4.0", "<0.5.0"]

    - package: dbt-labs/dbt_utils
      version: [">=1.0.0", "<2.0.0"]
```

## How is this package maintained and can I contribute?
### Package Maintenance
The Fivetran team maintaining this package _only_ maintains the latest version of the package. We highly recommend that you stay consistent with the [latest version](https://hub.getdbt.com/fivetran/greenhouse_source/latest/) of the package and refer to the [CHANGELOG](https://github.com/fivetran/dbt_greenhouse_source/blob/main/CHANGELOG.md) and release notes for more information on changes across versions.

### Contributions
A small team of analytics engineers at Fivetran develops these dbt packages. However, the packages are made better by community contributions.

We highly encourage and welcome contributions to this package. Check out [this dbt Discourse article](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) to learn how to contribute to a dbt package.

## Are there any resources available?
- If you have questions or want to reach out for help, see the [GitHub Issue](https://github.com/fivetran/dbt_greenhouse_source/issues/new/choose) section to find the right avenue of support for you.
- If you would like to provide feedback to the dbt package team at Fivetran or would like to request a new dbt package, fill out our [Feedback Form](https://www.surveymonkey.com/r/DQ7K7WW).
