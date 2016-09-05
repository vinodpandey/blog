## Resolving conflicts while creating a pull request in bitbucket

### Scenario
Code is being merged from branch css-changes to develop. While creating pull request, we get the error that there is a conflict in few files.

#### Clone the repository
```sh
git clone git@bitbucket.org:elpistechsolutionspvtltd/mycbseguide.com.git
```

#### Get the latest code for develop branch
```sh
git checkout develop
git pull origin develop
```

#### Get the latset code for css-changes brach
```sh
git checkout css-changes
git pull origin css-changes
```

#### Merge latest develop branch changes to css-changes
```sh
git merge develop

# it should show CONFLICT message
Auto-merging templates/learning/webbase.html
Auto-merging templates/learning/account/login_email.html
CONFLICT (content): Merge conflict in templates/learning/account/login_email.html
```

#### Manually resolve conflict in files
```sh
# Open file in vim or Notepad++
# <<<<<< and >>>>> shows the confilcts for particular line
# HEAD is current branch
# develop is remote develop branch
# ======= acts as separator between the conflicting lines
# to fix the conflict decide which change to take, and delete rest of the changes

<<<<<<< HEAD
                <div class="panel panel-default text-center paper-shadow clear-nav-top" data-z="0.5">
                    <h1 class="text-display-1">Log In</h1>
=======
                <div class="panel panel-default text-center paper-shadow clear-nav-top signin_container" data-z="0.5">
                    <h1 class="text-display-1">Sign In</h1>
>>>>>>> develop

In above case, we want to take the changes from develop branch. Delete other changes line by line (delete the whole line. in Vim use dd option to remove the line) and also remove the conflict marker - <<<<<<< HEAD ======= & >>>>>>> develop

above CONFLICT after fixing:

                <div class="panel panel-default text-center paper-shadow clear-nav-top signin_container" data-z="0.5">
                    <h1 class="text-display-1">Sign In</h1>


```

#### Commit and push changed files
```sh
git add templates/learning/account/login_email.html

git commit -m 'resolved conflicts'

result should look something link this
Vinods-MacBook-Pro:mycbseguide.com vinodpandey$ git commit -m 'resolved conflicts'
[css-changes 4dbd7c9] resolved conflicts

git push origin css-changes
```

#### Conflict should now be resolved in pull request in bitbucket
