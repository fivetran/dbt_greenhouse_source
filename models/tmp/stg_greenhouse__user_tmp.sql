select * from {{ var('users') if does_table_exist('users') else var('user') }}
