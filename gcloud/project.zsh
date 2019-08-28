genv () {
    project="$1"

    gcloud config set project $project
    kenv $project
}

gcb-ls () {
    currentproject="$(gcloud config get-value project)"
    project="${1:-$currentproject}"
    echo "Project: $project"
    gcloud builds list --project $project
}

gcb-logs () {
    currentproject="$(gcloud config get-value project)"
    project="${2:-$currentproject}"
    index="${1:-0}"
    echo "Project: $project. Index: $index"
    last_build=$(gcloud builds list --project $project --format json | jq -r ".[$index].id")
    gcloud builds log $last_build --project $project --stream
}