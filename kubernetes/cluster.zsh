kenv () {
    cluster=$(kubectl config get-contexts -o name | grep $1)
    kubectl config use-context $cluster
}

klogs () {
    app="$1"
    pod=$(kubectl get pods -l=app=$app | grep $app | awk '{print $1}')
    shift;
    kubectl logs $pod $@
}