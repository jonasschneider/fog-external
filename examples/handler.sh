#!sh
exec ruby -Ilib -rfog/external/backend/local -e 'Fog::External::Backend::Local.act_as_ernie_handler!'