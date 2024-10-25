select * from {{ var('tags') if does_table_exist('tags') else var('tag') }}
