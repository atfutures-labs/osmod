OSM building heights in Briston
===============================

``` r
devtools::load_all ("../../osmdata", export_all = FALSE)
```

    ## Loading osmdata

    ## Data (c) OpenStreetMap contributors, ODbL 1.0. http://www.openstreetmap.org/copyright

``` r
library (magrittr)
```

Resdiential buildings
---------------------

``` r
bb <- opq ('Bristol UK') %>% 
    add_feature (key = 'building', value = 'residential') %>%
    osmdata_sf ()
```

Only relevant objects are polygons, although there are also 3 multipolygons, but these only contain generic default info (name, address, geometry):

``` r
names (bb$osm_multipolygons)
```

    ## [1] "osm_id"           "name"             "addr.housename"  
    ## [4] "addr.housenumber" "addr.street"      "building"        
    ## [7] "type"             "geometry"

In contrast,

``` r
dim (bb$osm_polygons)
```

    ## [1] 1500   36

``` r
names (bb$osm_polygons)
```

    ##  [1] "osm_id"              "name"                "addr.city"          
    ##  [4] "addr.country"        "addr.district"       "addr.flats"         
    ##  [7] "addr.housename"      "addr.housenumber"    "addr.postcode"      
    ## [10] "addr.street"         "addr.suburb"         "amenity"            
    ## [13] "brand"               "building"            "building.flats"     
    ## [16] "building.levels"     "building.use"        "created_by"         
    ## [19] "cuisine"             "fhrs.id"             "layer"              
    ## [22] "note"                "operator"            "shop"               
    ## [25] "social_facility"     "social_facility.for" "source"             
    ## [28] "source.addr"         "source.address"      "source.outline"     
    ## [31] "source.postcode"     "takeaway"            "website"            
    ## [34] "wheelchair"          "wikipedia"           "geometry"

has `building.levels`. There are, however, only 9 out of 1,500 buildings that have this information, rendering it useless:

``` r
table (bb$osm_polygons$building.levels)
```

    ## 
    ## 1 2 3 5 
    ## 1 4 3 1

``` r
sum (table (bb$osm_polygons$building.levels))
```

    ## [1] 9

Commerical buildings
--------------------

``` r
bc <- opq ('Bristol UK') %>% 
    add_feature (key = 'building', value = 'commercial') %>%
    osmdata_sf ()
```

``` r
dim (bc$osm_polygons)
```

    ## [1] 283  68

``` r
names (bc$osm_polygons)
```

    ##  [1] "osm_id"             "name"               "abandoned.building"
    ##  [4] "addr.city"          "addr.country"       "addr.district"     
    ##  [7] "addr.hamlet"        "addr.housename"     "addr.housenumber"  
    ## [10] "addr.place"         "addr.postcode"      "addr.street"       
    ## [13] "addr.suburb"        "addr.unit"          "alt_name"          
    ## [16] "amenity"            "atm"                "building"          
    ## [19] "building.levels"    "comment"            "contact.email"     
    ## [22] "contact.phone"      "contact.website"    "cuisine"           
    ## [25] "date_started"       "diet.vegetarian"    "email"             
    ## [28] "facebook"           "fax"                "fhrs.id"           
    ## [31] "fixme"              "food"               "height"            
    ## [34] "historic"           "leisure"            "level"             
    ## [37] "listed_status"      "loc_name"           "note"              
    ## [40] "office"             "old_name"           "opening_hours"     
    ## [43] "operator"           "owner"              "phone"             
    ## [46] "phone.events"       "phone.reservation"  "phone.uk"          
    ## [49] "postal_code"        "roof.levels"        "shop"              
    ## [52] "smoking"            "source"             "source.addr"       
    ## [55] "source.alt_name"    "source.outline"     "source.track"      
    ## [58] "sport"              "start_date"         "storage"           
    ## [61] "takeaway"           "tourism"            "twitter"           
    ## [64] "website"            "wheelchair"         "wifi"              
    ## [67] "wikipedia"          "geometry"

``` r
table (bc$osm_polygons$building.levels)
```

    ## 
    ##  1 15  2  3  4  5  6  7 
    ##  5  3  1  2  4  1  1  1

``` r
sum (table (bc$osm_polygons$building.levels))
```

    ## [1] 18

Slightly more bulidings with specified levels, but still not enough to be useful. And unforuntely only one building with `height` value:

``` r
table (bc$osm_polygons$height)
```

    ## 
    ## 21 
    ##  1

So unfortunately, heights of commerical buildings can also not be extracted.

Industrial buildings
--------------------

``` r
bi <- opq ('Bristol UK') %>% 
    add_feature (key = 'building', value = 'industrial') %>%
    osmdata_sf ()
```

``` r
dim (bi$osm_polygons)
```

    ## [1] 631  30

``` r
names (bi$osm_polygons)
```

    ##  [1] "osm_id"           "name"             "addr.city"       
    ##  [4] "addr.housename"   "addr.housenumber" "addr.place"      
    ##  [7] "addr.postcode"    "addr.street"      "alt_name"        
    ## [10] "building"         "building.levels"  "comment"         
    ## [13] "construction"     "description"      "designation"     
    ## [16] "ele"              "fixme"            "frequency"       
    ## [19] "layer"            "man_made"         "old_name"        
    ## [22] "owner"            "power"            "roof.levels"     
    ## [25] "shop"             "source"           "source.outline"  
    ## [28] "source.track"     "website"          "geometry"

``` r
table (bi$osm_polygons$building.levels)
```

    ## 
    ##          1 2, 4, 6... 
    ##          1          1

``` r
sum (table (bi$osm_polygons$building.levels))
```

    ## [1] 2

Building levesl are again useless, and there are no heights at all.
