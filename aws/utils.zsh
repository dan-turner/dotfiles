export AWS_PROFILE="default"

awsrc_echo () {
	command printf %s\\n "$*" 2> /dev/null
}

awsrc_find_up () {
	local path_
	path_="${PWD}"
	while [ "${path_}" != "" ] && [ ! -f "${path_}/${1-}" ]
	do
		path_=${path_%/*}
	done
	awsrc_echo "${path_}"
}

awsrc_find_awsrc () {
	local dir
	dir="$(awsrc_find_up '.awsrc')"
	if [ -e "${dir}/.awsrc" ]
	then
		awsrc_echo "${dir}/.awsrc"
	fi
}

load-awsrc() {
  local awsrc_path="$(awsrc_find_awsrc)"

  if [ -n "$awsrc_path" ]; then
    local awsrc_profile=$(cat "${awsrc_path}")

    export AWS_PROFILE="$awsrc_profile"
    echo "Now using AWS profile \"$AWS_PROFILE\""
  elif [ "$AWS_PROFILE" != "default" ]; then
    echo "Reverting to default AWS profile"
    export AWS_PROFILE="default"
  fi
}
