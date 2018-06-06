
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

