# it is a git update script that works on defined repositories in repolist
# ssh keys for user needs to be recognised by git to prevent auth.
# script ignores files named "Untitled"

#!/bin/sh	
if pidof -x "update" -o $$ >/dev/null	then
echo "Script is still running. Let it finish!"	
exit 1	
fi


now="$(date)"	
printf "Push starts at: %s\n" "$now"	
(	
printf "Start: %s\n\n" "$now"	
sudo su	
for i in $(cat /home/repolist)	
do 
cd /home/$i	
git remote add origin ssh:<repo_link>/$i.git	
find . -type f \( -iname "*" ! -iname "Untitled*" \) |grep -v [[:space:]]| xargs git add	
git commit -m "scheduled commit"	git push origin master
done	

finish="$(date)"	
printf "End: %s\n" "$finish"	
) 2> "$HOME/stderr.log" 1>"$HOME/stdout.log"	
finish="$(date)"	
printf "Push ends at: %s\n" "$finish"	
