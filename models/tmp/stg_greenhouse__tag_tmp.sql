select * from {{ var('tag') if does_table_exist('tag') else var('tags') }}
