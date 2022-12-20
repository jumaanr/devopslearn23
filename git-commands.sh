#!/bin/bash

# Installation #
sudo apt update
sudo apt install git -y
git --version

#Getting help
git help #Get the help and command palatte
git show #show various types of objects
git help <command> #view additional help on each command

#Git start-up
git init #Init a Git Repository, this will create the directory structure .git hidden directory
git status #Check the branches , Commits and Untracked files
git add myFile.json #Stage a file for commit ready
git commit -m "Added first story" #commit all staged files with a useful comment
git config user.name "sarah" #add a user for commit, so all commits are recorded in the name of the author
git config user.email "sarah@example.com"  #add user's email address who perform commit
git commit #when you open this command without any options , opens a text editor - here you provide a commit message 
git add .  #stage all the files in working area

#Recover and Remove
#Even if you commit or staged a file a copy will be saved, so you can restore the file
git restore myFile.json
git restore --staged myFile.json #remove a file from staging area
git rm notes.txt -f/--cached  #remove a tracked file , --cached option will retain the file in directory, -f option will delete file permanently.
# Still we can see the file untracked state , to ignore this file permanently add that file name to a file called .gitignore
echo "myFile.json" >> .gitignore
cat .ignore

#Git Log - Checking commit history
git log  # check the details of commit history
git log --oneline # get a short description of commit history
git log --name-only #get the list of changed files and their authors/modifires
git log -n <number>  #get -n number of the latest (reverse chrono order) record of commit history , to get the latest value is '1'
git log --graph --decorate #to see previous commit history along with the branch they were committed on

#Git Branching
git branch newBranch  #Create a new branch
git checkout newBranch #Switch branches
git checkout -b newBranch2  #Create a new branch and immediately switch to the new branch
git branch -d newBranch2 #Delete a branch 
git branch #list all the branches currently you have

#Git Mergin a Branch
git checkout master  #checkout to master branch
git merge feature/signup #perform the merge 

#Remote Repositories (GitHub)

#git remote add origin <Connection_String> ,Add a remote repo for a local project.This is a name for the remote, and also can have multiple remote repositories
git remote add origin https://..../../[name].git 
git remote -v  #List all remote repositories
git push origin master  # git push <aliasOfRemoteRepo> <CurrentBranch/BranchName>  , Push the data to remote repo
git clone http://git.example.com/sarah/story-blog  #clone a remote repository locally and work on it
#git clone [ssh link] 
#Once we cloned , we dont have to add the repository using git remote add command. Because in the clonning it automatically get added 

#Fetching and Pulling
git fetch origin master #Update orgin/master branch in our local repository
git merge orgin/master #now we have an updated local master
git branch -a # view all the branches both local and remote
git pull origin master # We can fetch and merge remote changes directly into our local master branch. No need to perform fetch and merge seperately. 


