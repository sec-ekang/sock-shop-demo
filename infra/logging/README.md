# kube-logging

First create the kube-logging namespace using the `00-kube-logging-ns.yaml` file:

`$ kubectl create -f 00-kube-logging-ns.yaml`


### fluentd

To deploy simply apply all the fluentd manifests (01-05) in any order:

`kubectl apply $(ls *-fluentd-*.yaml | awk ' { print " -f " $1 } ')`

### elasticearch and kibana

`kubectl apply 06-elasticsearch.yaml`

`kubectl apply 07-kibana.yaml`
