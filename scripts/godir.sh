
#gettop="/home/glenn"


function gettop()
{
	REPOFILE=".godir_tag_file"
	#PWD=`pwd`
	local HERE=$PWD
	T=
	while [ \( ! \( -f $REPOFILE \) \) -a \( $PWD != "/" \) ]; do
		\cd ..
		T=`PWD= /bin/pwd -P`
	done
	T=`PWD= /bin/pwd -P`
	\cd $HERE
	if [ -d "$T/$REPOFILE" ]; then
		echo $T
	fi
	echo $T
}

#croot
function cr()
{
	T=$(gettop)
	echo $T
	if [ "$T" ]; then
		\cd $(gettop)
	else
		echo "Couldn't locate the top of the tree.  Try setting TOP."
	fi
}

# create index file
function ci()
{
	topdir=$1
	if [ "$topdir" ]; then
		T=$topdir
		touch .godir_tag_file
	else
		T=$(gettop)
	fi
	echo "$T"
	echo -n "Creating index..."
	(\cd $T; find . -wholename ./.git -prune -o -wholename ./output -prune -o -wholename ./build -prune -o -wholename ./deploy -prune -o -wholename ./out -prune -o -wholename ./.repo -prune -o -wholename ./sdks -prune -o -type d > filelist)
	echo " Done"
	echo ""
}

# add folde into index file
function ca()
{
	if [[ -z "$1" ]]; then
		echo "Usage: ca <regex>"
		return
	fi
	T=$(gettop)
	echo "$T"
	echo -n "Creating index..."
	(\cd $T; find ./$1 -wholename ./out -prune -o -wholename ./.repo -prune -o -wholename ./sdks -prune -o -type d >> filelist)
	echo " Done"
	echo ""
}

#godir
function go()
{
	if [[ -z "$1" ]]; then
		echo "Usage: go <regex>"
		return
	fi
	T=$(gettop)
	if [[ ! -f $T/filelist ]]; then
		echo -n "Creating index..."
		(\cd $T; find . -wholename ./out -prune -o -wholename ./.repo -prune -o -wholename ./sdks -prune -o -type d > filelist)
		echo " Done"
		echo ""
	fi
	local lines
	#lines=($(\grep "/$1\$" $T/filelist | sed -e 's/\/[^/]*$//' | sort | uniq))
	lines=($(\grep "/[-a-z0-9A-Z_]*$1[-a-z0-9A-Z_\.]*$" $T/filelist | sort | uniq))
	if [[ ${#lines[@]} = 0 ]]; then
		echo "Not found"
		return
	fi
	local pathname
	local choice
	if [[ ${#lines[@]} > 1 ]]; then
		while [[ -z "$pathname" ]]; do
			local index=1
			local line
			for line in ${lines[@]}; do
				printf "%6s %s ---- %s\n" "[$index]" $line "[$index]"
				index=$(($index + 1))
			done
			echo
			echo -n "Select one: "
			unset choice
			read choice
			if [[ $choice -gt ${#lines[@]} || $choice -lt 1 ]]; then
				echo "Invalid choice"
				continue
			fi
			pathname=${lines[$(($choice-1))]}
		done
	else
		pathname=${lines[0]}
	fi
	\cd $T/$pathname
}
