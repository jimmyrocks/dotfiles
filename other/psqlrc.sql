-- More tips here: http://phili.pe/posts/postgresql-on-the-command-line/#configuring-psql

\set QUIET 1

\pset null '␀'

\set COMP_KEYWORD_CASE upper

\timing

\set HISTSIZE 5000

\x auto

\set VERBOSITY verbose

\set QUIET 0

\echo 'psqlrc file loaded! \n'
