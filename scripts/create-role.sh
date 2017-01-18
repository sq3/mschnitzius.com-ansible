#!/bin/bash

role_name=$1
role_dir="./roles"
working_dir=$role_dir/$role_name

function test_construct {
	if [ 1 ]
	then
			echo -e "\n ✗ | an ERROR occurred"
			exit 1
	fi
}

mkdir $working_dir > /dev/null

cd $working_dir

git init . > /dev/null

mkdir -p ./defaults \
		./files \
		./tasks \
		./vars \
		> /dev/null

touch ./defaults/main.yml \
		./files/main.yml \
		./tasks/main.yml \
		./vars/main.yml \
		

		> /dev/null

printf "

create ansible role: $role_name
--------------------------------------------------
 ✓   role $role_name created
"

printf "
# Ansible role $role_name
" > README.md

printf "
 !!  do you want to push this role to github? \n

 !!  this requires that you've set up this repo on github.com

 >>  press ENTER to continue
"
read

git add . > /dev/null

git commit -m "initialy create role $role_name" > /dev/null

git remote add origin git@github.com:sq3/ansible-role-$role_name.git

git push -u origin master > /dev/null

printf "
 !!  do you want to add $role_name as submodule?

 >>  press ENTER to continue and CTRL + c to exit
--------------------------------------------------
"
read

rm -rf $working_dir

git submodule add git@github.com:sq3/ansible-role-$role_name.git \
/role/$role_name > /dev/null

