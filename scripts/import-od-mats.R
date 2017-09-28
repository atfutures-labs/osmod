library(sf)
am_commute = readr::read_csv("/tmp/AM_COM.csv", col_names = FALSE)
am_non_commute = readr::read_csv("/tmp/AM_NCOM.csv", col_names = FALSE)
unzip("/tmp/LoHAM_5194_T1_Cyn.zip", exdir = "/tmp/")
z_tfl = sf::read_sf("/tmp/LoHAM_5194_T1_Cyn.shp")
names(z_tfl)
summary(z_tfl$Cynemn_zn)
sel_od = z_tfl$Cynemn_zn %in% am_commute$X1 | z_tfl$Cynemn_zn %in% am_commute$X2
z_tfl = dplyr::filter(z_tfl, sel_od)
am_commute = dplyr::filter(am_commute, am_commute$X1 %in% z_tfl$Cynemn_zn & am_commute$X2 %in% z_tfl$Cynemn_zn)
od_tfl = stplanr::od2line(am_commute, z_tfl) # not working...
mapview::mapview(z_tfl)

sum(am_commute$X3) / 4e6
