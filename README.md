# update-server-django-project-script
A tiny script to update your Django project in the server. It pulls your repo, collects the static files of your project and restarts the web server. Migrations are not included since needs more supervision.

This example is using:
- Gitlab as repository hosting service
- Gunicorn as Web Server Gateway Interface HTTP server
- Nginx as webserver

Execute using:  
`./pushtoserver.sh <server ip> <server user> <server password> <gitlab user> <gitlab password>`
