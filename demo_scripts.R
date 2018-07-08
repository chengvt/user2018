# Number of daily package downloads via CRAN
load("data.RData")
colordf1 <- data.frame(key = unique(dat$package),
                       color = c(ggsci::pal_igv()(51), 
                                 ggsci::pal_igv()(9)))
MovingBubbles(df = dat, 
              key = "package",
              frame = "date",
              value = "downloads",
              color = colordf1)