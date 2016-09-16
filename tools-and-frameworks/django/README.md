


## Migrations
### Workflow
* Create or update a model
* Create migrations
  ```
  ./manage.py makemigrations <app_name>
  ```
* Apply migrations
  ```
  ./manage.py migrate <app_name>
  ```

### Other userful commands
* List all migrations
  ```
  ./manage.py showmigrations --list
  ./manage.py showmigrations <app_name> --list
  ```
* Generate SQL for migration
  ```
  ./manage.py sqlmakemigrate <app_name> <migration_name>
  ```
* Fake migrations
  ```
  ./manage.py migrate --fake <appname>
  ```
