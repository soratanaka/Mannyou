# README



##User
|column|type|
|:-----|:----:|
|id|-|
|name|string|
|email|string|
|password|string|

##Task
|column|type|
|:-----|:----:|
|id|-|
|user_id|-|
|name|string|
|content|text|
|time|date|
|priority|integer|
|status|integer|

##label
|column|type|
|:-----|:----:|
|id|-|
|user_id|-|
|task_id|-|

Herokuへのデプロイ手順
heroku login
heroku create
heroku stack:set heroku-20
bundle lock --add-platform x86_64-linux
git add .
git commit *****
git push heroku *****:master