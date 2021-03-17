# Greenhouse Source ([docs](https://fivetran-dbt-greenhouse.netlify.app/#!/overview))

This package models Greenhouse recruiting data from [Fivetran's connector](https://fivetran.com/docs/applications/greenhouse). It uses data in the format described by [this ERD](https://fivetran.com/docs/applications/greenhouse#schemainformation).

This package enriches your Fivetran data by doing the following:
* Adds descriptions to tables and columns that are synced using Fivetran
* Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
* Models staging tables, which will be used in our transform package

## Models 

This package contains staging models, designed to work simultaneously with our [Greenhouse modeling package](https://github.com/fivetran/dbt_greenhouse). The staging models:
* Remove any rows that are soft-deleted
* Name columns consistently across all packages:
    * Boolean fields are prefixed with `is_` or `has_`
    * Timestamps are appended with `_at`
    * ID primary keys are prefixed with the name of the table. For example, a user table's ID column is renamed `user_id`.
    * Foreign keys include the table that they refer to. For example, an application's recruiter user ID column is renamed `recruiter_user_id`.

## Installation Instructions
Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

## Configuration
By default, this package looks for your Greenhouse data in the `greenhouse` schema of your [target database](https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/configure-your-profile). If this is not where your Greenhouse data is, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
config-version: 2

vars:
    greenhouse_database: your_database_name
    greenhouse_schema: your_schema_name 
```

### Passthrough Custom Columns
The Greenhouse `APPLICATION`, `JOB`, and `CANDIDATE` tables may have custom columns, all prefixed with `custom_field_`. To pass these columns along to the staging and final transformation models, add the following variables to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
config-version: 2

vars:
    greenhouse_application_custom_columns: ['the', 'list', 'of', 'columns'] # these columns will be in the final application_enhanced model
    greenhouse_candidate_custom_columns: ['the', 'list', 'of', 'columns'] # these columns will be in the final application_enhanced model
    greenhouse_job_custom_columns: ['the', 'list', 'of', 'columns'] # these columns will be in the final job_enhanced model
```

### Disabling Models
Your Greenhouse connector might not sync every table that this package expects. If your syncs exclude certain tables, it is because you either don't use that functionality in Greenhouse or have actively excluded some tables from your syncs.

To disable the corresponding functionality in the package, you must add the relevant variables. By default, all variables are assumed to be `true`. Add variables for only the tables you would like to disable:

```yml
# dbt_project.yml

...
config-version: 2

vars:
    greenhouse_using_prospects: false # Disable if you do not use prospects and/or do not have the PROPECT_POOL and PROSPECT_STAGE tables synced
    greenhouse_using_eeoc: false # Disable if you do not have EEOC data synced and/or do not want to integrate it into the package models
    greenhouse_using_app_history: false # Disable if you do not have APPLICATION_HISTORY synced and/or do not want to run the application_history transform model
    greenhouse_using_job_office: false # Disable if you do not have JOB_OFFICE and/or OFFICE synced, or do not want to include offices in the job_enhanced transform model
    greenhouse_using_job_department: false # Disable if you do not have JOB_DEPARTMENT and/or DEPARTMENT synced, or do not want to include offices in the job_enhanced transform model
```

*Note: This package only integrates the above variables. If you'd like to disable other models, please create an [issue](https://github.com/fivetran/dbt_greenhouse_source/issues) specifying which ones.*

## Contributions
Don't see a model or specific metric you would have liked to be included? Notice any bugs when installing 
and running the package? If so, we highly encourage and welcome contributions to this package! 
Please create issues or open PRs against `master`. See [the Discourse post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) for information on how to contribute to a package.

## Database Support
This package has been tested on BigQuery, Snowflake and Redshift.

## Resources:
- Provide [feedback](https://www.surveymonkey.com/r/DQ7K7WW) on our existing dbt packages or what you'd like to see next
- Have questions, feedback, or need help? Book a time during our office hours [using Calendly](https://calendly.com/fivetran-solutions-team/fivetran-solutions-team-office-hours) or email us at solutions@fivetran.com
- Find all of Fivetran's pre-built dbt packages in our [dbt hub](https://hub.getdbt.com/fivetran/)
- Learn how to orchestrate [dbt transformations with Fivetran](https://fivetran.com/docs/transformations/dbt)
- Learn more about Fivetran overall [in our docs](https://fivetran.com/docs)
- Check out [Fivetran's blog](https://fivetran.com/blog)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
