
Request #1
It should return locations which belong to the selected country based on it's current panel provider

It is unclear  what kind of relation country has with locations.
My first assumption was that location needs to belong to location_group, 
but there is no 'location_group_id' in Location def which would indicate belong_to relation.
I am going with many to many relation for Location and Location Group.

Index name 'index_location_group_location_relations_on_location_id_and_location_group_id' on table 'location_group_location_relations' is too long; the limit is 62 characters
that is why I had to shorten relations names (not best approach) .

For generating tree struture I used:
https://github.com/ClosureTree/closure_tree

For using private api appropriate header needs to be indcluded : accept: application/vnd.agency.private+json .
Furhtermore user has to be part of provider organization i.e. to has panel_provider_id present in order to use private api.

== Caused by : Closure Tree implementation of adding children. Assume it will be fixed soon. 
DEPRECATION WARNING: Dangerous query method (method whose arguments are used as raw SQL) called with non-attribute argument(s): "\"target_group_hierarchies\".generations asc". Non-attribute arguments will be disallowed in Rails 6.0. This method should not be called with user-provided values, such as request parameters or model attributes. Known-safe values can be passed by wrapping them in Arel.sql(). (called from block (3 levels) in <main> at /Users/stevanrakic/Smart/Rails/Volcano/project/spec/requests/target_groups_spec.rb:24)


