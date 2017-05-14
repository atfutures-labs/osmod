``` r
devtools::load_all ("../../osmdata", export_all = FALSE)
```

    ## Loading osmdata

    ## Data (c) OpenStreetMap contributors, ODbL 1.0. http://www.openstreetmap.org/copyright

``` r
library (magrittr)
```

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
