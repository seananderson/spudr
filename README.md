# spudr

An R package for tracking and managing couch-potato-style investment portfolios
in the spirit of <http://canadiancouchpotato.com/>.

This is a work in progress as I bring over an assortment of functions I've been
using for tracking portfolios. Right now it doesn't do much.

You can install the package with:
```S
# install.packages("devtools") # if necessary
devtools::install_github("seananderson/spudr")
library("spudr")
```

One thing the package does that you might find useful, is to return a data frame
(or append data to a .csv file) with today's stock values for a vector of stock
symbols. The data come from Google Finance in real time. For example:

```S
s <- c("VAB", "XRB", "ZRE", "XEC", "XEF", "XIC", "VUN", "TDB909", "TDB911")
google_dat(s)
##         Date   VAB  XRB   ZRE   XEC   XEF   XIC   VUN TDB909 TDB911
##   2014-10-15 25.45 24.5 19.34 21.39 22.59 21.96 29.34   11.6  10.89
```
