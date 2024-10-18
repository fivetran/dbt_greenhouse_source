select * from {{ var('user') if does_table_exist('user') else var('users') }}
