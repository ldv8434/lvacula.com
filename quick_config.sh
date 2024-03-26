# PRESETS
GITHUB_URL="git@github.com:ldv8434/lvacula.com.git"
GITEA_URL="https://git.vacula.xyz/dracula/lvacula.com-blog.git"
GIT_USER="Lukas Vacula"
GIT_EMAIL="ldv8434@rit.edu"

# Verify git-lfs installed
if ! git lfs -v &> /dev/null
then
	echo -e "\033[0;31mgit-lfs is not installed.\nPlease add it before adding any large binary files.\033[0m"
else
	git lfs install &> /dev/null
fi

# Set User
git config user.name "$GIT_USER" --replace-all
git config user.email "$GIT_EMAIL"

# Sanity item
git config credential.helper cache

OPTSTRING=":rfh"
# Set Remotes
while getopts ${OPTSTRING} opt; do
	case ${opt} in
		r)
			echo "Configuring remotes"
			git remote add github $GITHUB_URL
			git remote add gitea $GITEA_URL
			git remote add origin $GITEA_URL
			git remote set-url --add --push origin $GITHUB_URL
			git remote set-url --add --push origin $GITEA_URL
			;;
		f)
			echo "Rebaseing commits - be sure to 'git push --force'"
			git rebase -r --root --exec "git commit --amend --no-edit --reset-author"
			;;	
		h)
			echo -e "-r: configure remotes for multi-push\n-f: fix commits using rebase"
			;;
	esac
done

# To retroactively fix commits, use the following command:
# git rebase -r --root --exec "git commit --amend --no-edit --reset-author"
# git push --force
# **WARNING** This will set *all* commits to the same author.

