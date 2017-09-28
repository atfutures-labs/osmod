
OSM building heights in Bristol
===============================

``` r
library(osmdata)
```

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

    ## add_feature() is deprecated; please use add_osm_feature()

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

    ## [1] 1502   37

``` r
names (bb$osm_polygons)
```

    ##  [1] "osm_id"              "name"                "FIXME"              
    ##  [4] "addr.city"           "addr.country"        "addr.district"      
    ##  [7] "addr.flats"          "addr.housename"      "addr.housenumber"   
    ## [10] "addr.postcode"       "addr.street"         "addr.suburb"        
    ## [13] "amenity"             "brand"               "building"           
    ## [16] "building.flats"      "building.levels"     "building.use"       
    ## [19] "cuisine"             "fhrs.id"             "layer"              
    ## [22] "note"                "operator"            "shop"               
    ## [25] "social_facility"     "social_facility.for" "source"             
    ## [28] "source.addr"         "source.address"      "source.outline"     
    ## [31] "source.postcode"     "takeaway"            "website"            
    ## [34] "wheelchair"          "wikidata"            "wikipedia"          
    ## [37] "geometry"

has `building.levels`. There are, however, only 9 out of 1,500 buildings that have this information, rendering it useless:

``` r
table (bb$osm_polygons$building.levels)
```

    ## 
    ## 1 2 3 5 
    ## 1 4 3 2

``` r
sum (table (bb$osm_polygons$building.levels))
```

    ## [1] 10

Commercial buildings
--------------------

``` r
bc <- opq ('Bristol UK') %>% 
    add_feature (key = 'building', value = 'commercial') %>%
    osmdata_sf ()
```

    ## add_feature() is deprecated; please use add_osm_feature()

``` r
dim (bc$osm_polygons)
```

    ## [1] 303  72

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
    ## [25] "date_started"       "description"        "diet.vegetarian"   
    ## [28] "disused.amenity"    "drink"              "email"             
    ## [31] "facebook"           "fax"                "fhrs.id"           
    ## [34] "fixme"              "food"               "height"            
    ## [37] "historic"           "layer"              "leisure"           
    ## [40] "level"              "listed_status"      "loc_name"          
    ## [43] "note"               "office"             "old_name"          
    ## [46] "opening_hours"      "operator"           "owner"             
    ## [49] "phone"              "phone.events"       "phone.reservation" 
    ## [52] "phone.uk"           "postal_code"        "roof.levels"       
    ## [55] "shop"               "smoking"            "source"            
    ## [58] "source.addr"        "source.alt_name"    "source.outline"    
    ## [61] "source.track"       "sport"              "start_date"        
    ## [64] "storage"            "takeaway"           "tourism"           
    ## [67] "twitter"            "website"            "wheelchair"        
    ## [70] "wifi"               "wikipedia"          "geometry"

``` r
table (bc$osm_polygons$building.levels)
```

    ## 
    ##  1 15  2  3  4  5  6  7 
    ##  4  3  1  9  8  2  3  7

``` r
sum (table (bc$osm_polygons$building.levels))
```

    ## [1] 37

Slightly more buildings with specified levels, but still not enough to be useful. And unfortunately only one building with `height` value:

``` r
table (bc$osm_polygons$height)
```

    ## 
    ## 21 
    ##  1

So unfortunately, heights of commercial buildings can also not be extracted.

Industrial buildings
--------------------

``` r
bi <- opq ('Bristol UK') %>% 
    add_feature (key = 'building', value = 'industrial') %>%
    osmdata_sf ()
```

    ## add_feature() is deprecated; please use add_osm_feature()

``` r
dim (bi$osm_polygons)
```

    ## [1] 632  30

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
    ##          1          2 2, 4, 6...          3 
    ##          1          1          1          1

``` r
sum (table (bi$osm_polygons$building.levels))
```

    ## [1] 4

Building levels are again useless, and there are no heights at all.

Conclusion to that point:
=========================

OSM data are currently pretty useless, alas. Nevertheless the following points are likely very important:

1.  That conclusion took about 10 minutes to develop and run the script;
2.  That conclusion would certainly be different in different parts of the world (Germany has many more building heights), and the data will only get better everywhere no matter what, so:
3.  This whole project will certainly develop a very future-safe way of attaining our end result, regardless of the detours we're going to have to take to get there in prototype form.
