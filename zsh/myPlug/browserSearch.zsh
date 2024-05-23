google() {
	if [ $(echo $1 | grep "^-[gv]$") ]; then
		local opt=$1
		shift
	fi
	local url="https://google.co.jp/search?q=${*// /+}"
	local g="Google Chrome"
	local v="Vivaldi"
	case $opt in
	-g) open $url -a $g ;;
	-v) open $url -a $v ;;
	*) open $url ;;
	esac
}

