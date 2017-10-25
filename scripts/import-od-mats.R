library(sf)
library(dplyr)
library(tmap)
library(devtools)
devtools::install_github("ropensci/stplanr")
# am_commute = readr::read_csv("/tmp/AM_COM.csv", col_names = FALSE)
# am_non_commute = readr::read_csv("/tmp/AM_NCOM.csv", col_names = FALSE)
# unzip("/tmp/LoHAM_5194_T1_Cyn.zip", exdir = "/tmp/")
# z_tfl = sf::read_sf("/tmp/LoHAM_5194_T1_Cyn.shp")
# saveRDS(am_commute, "~/gmost/cyoddata/am_commute.Rds")
# saveRDS(am_non_commute, "~/gmost/cyoddata/am_non_commute.Rds")
# saveRDS(z_tfl_orig, "~/gmost/cyoddata/z_tfl.Rds")
# if(object.size(z_tfl_orig) >= 32261664) {
#   z_tfl_orig = rmapshaper::ms_simplify(z_tfl_orig, keep = 0.01)
# }
# saveRDS(z_tfl_orig, "~/gmost/cyoddata/z_tfl.Rds")

z_tfl_orig = readRDS("~/gmost/cyoddata/z_tfl.Rds")
am_commute = readRDS("~/gmost/cyoddata/am_commute.Rds")
am_non_commute = readRDS("~/gmost/cyoddata/am_non_commute.Rds")
qtm(z_tfl_orig)
sel_od = z_tfl_orig$Cynemn_zn %in% am_commute$X1 | z_tfl_orig$Cynemn_zn %in% am_commute$X2
z_tfl = dplyr::filter(z_tfl_orig, sel_od)
summary(z_tfl$Cynemn_zn)
am_commute = dplyr::filter(am_commute, am_commute$X1 %in% z_tfl$Cynemn_zn & am_commute$X2 %in% z_tfl$Cynemn_zn)
z_tfl = dplyr::select(z_tfl, Cynemn_zn)
od_tfl = stplanr::od2line(am_commute, z_tfl)
od_tfl = dplyr::filter(od_tfl, X1 != X2)
z = st_simplify(z_tfl, dTolerance = 30, preserveTopology = T)
tmap_mode("view")
qtm(z) +
  tm_shape(od_tfl) +
  tm_lines(col = "X3", alpha = 0.2) +
  tm_style_cobalt()

mapview::mapview(z_tfl) +
  mapview::mapview(dplyr::filter(od_tfl, X3 > 200), col = od_tfl)

sum(am_commute$X3) / 4e6

p_flows_lnd = readr::read_csv("/tmp/CynemonPotentialFlows_R031ST_Points.csv")
psf = p_flows_lnd %>% 
  select(Easting, Northing) %>% 
  as.matrix() %>% 
  st_multipoint() %>% 
  st_sfc() %>% 
  st_cast(to = "POINT") %>% 
  st_sf(crs = 27700) %>% 
  st_transform(crs = 4326)
library(leaflet.extras)
leaflet() %>% 
  addProviderTiles("OpenStreetMap.BlackAndWhite") %>% 
  addHeatmap(lng = st_coordinates(psf)[, 1], lat = st_coordinates(psf)[, 2], intensity = p_flows_lnd$`AM Peak Hour 2 Way Cycle Flow` / 1e4, radius = 10)
