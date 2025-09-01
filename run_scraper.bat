@echo off
echo Starting Google Maps Scraper locally...
echo.
echo Keywords for Netherlands:
echo Zip Screen in Amsterdam, Netherlands
echo Zip Blinds in Rotterdam, Netherlands
echo Bioclimatic in Utrecht, Netherlands
echo Rolling Roof in The Hague, Netherlands
echo Winter Garden in Eindhoven, Netherlands
echo Awnings in Groningen, Netherlands
echo.
echo Keywords for Germany:
echo Zip Screen in Berlin, Germany
echo Zip Blinds in Munich, Germany
echo Bioclimatic in Hamburg, Germany
echo Rolling Roof in Cologne, Germany
echo Winter Garden in Frankfurt, Germany
echo Glass Systems in Stuttgart, Germany
echo.
docker build -t google-maps-scraper .
docker run -p 8080:8080 google-maps-scraper
pause
