# Google Maps Scraper - Command Line Usage

## Netherlands Companies
google-maps-scraper -input "Zip Screen in Amsterdam, Netherlands" -output netherlands_zip_screen.json -email true -depth 5
google-maps-scraper -input "Zip Blinds in Rotterdam, Netherlands" -output netherlands_zip_blinds.json -email true -depth 5
google-maps-scraper -input "Bioclimatic in Utrecht, Netherlands" -output netherlands_bioclimatic.json -email true -depth 5
google-maps-scraper -input "Rolling Roof in The Hague, Netherlands" -output netherlands_rolling_roof.json -email true -depth 5
google-maps-scraper -input "Winter Garden in Eindhoven, Netherlands" -output netherlands_winter_garden.json -email true -depth 5
google-maps-scraper -input "Awnings in Groningen, Netherlands" -output netherlands_awnings.json -email true -depth 5
google-maps-scraper -input "Folding Systems in Tilburg, Netherlands" -output netherlands_folding.json -email true -depth 5
google-maps-scraper -input "Sliding Systems in Breda, Netherlands" -output netherlands_sliding.json -email true -depth 5
google-maps-scraper -input "Guillotine Systems in Apeldoorn, Netherlands" -output netherlands_guillotine.json -email true -depth 5
google-maps-scraper -input "Pergola in Nijmegen, Netherlands" -output netherlands_pergola.json -email true -depth 5
google-maps-scraper -input "Glass Systems in Haarlem, Netherlands" -output netherlands_glass.json -email true -depth 5

## Germany Companies  
google-maps-scraper -input "Zip Screen in Berlin, Germany" -output germany_zip_screen.json -email true -depth 5
google-maps-scraper -input "Zip Blinds in Munich, Germany" -output germany_zip_blinds.json -email true -depth 5
google-maps-scraper -input "Bioclimatic in Hamburg, Germany" -output germany_bioclimatic.json -email true -depth 5
google-maps-scraper -input "Rolling Roof in Cologne, Germany" -output germany_rolling_roof.json -email true -depth 5
google-maps-scraper -input "Winter Garden in Frankfurt, Germany" -output germany_winter_garden.json -email true -depth 5
google-maps-scraper -input "Awnings in Stuttgart, Germany" -output germany_awnings.json -email true -depth 5
google-maps-scraper -input "Folding Systems in Düsseldorf, Germany" -output germany_folding.json -email true -depth 5
google-maps-scraper -input "Sliding Systems in Dortmund, Germany" -output germany_sliding.json -email true -depth 5
google-maps-scraper -input "Guillotine Systems in Essen, Germany" -output germany_guillotine.json -email true -depth 5
google-maps-scraper -input "Pergola in Leipzig, Germany" -output germany_pergola.json -email true -depth 5
google-maps-scraper -input "Glass Systems in Dresden, Germany" -output germany_glass.json -email true -depth 5

## Batch Processing (All at once)
google-maps-scraper -input queries.txt -output all_results.json -email true -depth 5 -workers 2
