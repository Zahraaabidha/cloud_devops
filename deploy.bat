@echo off
echo Building app...
call npm run build
echo.
echo Pushing to GitHub...
git add .
git commit -m "Deploy %date% %time%"
git push origin main
echo.
echo Done! Jenkins will deploy automatically in 2 minutes.
echo Check: http://100.51.214.55:8080