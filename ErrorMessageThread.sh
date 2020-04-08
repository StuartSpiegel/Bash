function die()
{
    local m="$1"	# message
    local e=${2-1}	# default exit status 1
    echo "$m"
    exit $e
}
