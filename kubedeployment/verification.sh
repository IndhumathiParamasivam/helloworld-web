if [[ $(kubectl get deploy hello-world-V${{ github.run_number }} -o json | jq '.status.conditions[] | select(.reason == "MinimumReplicasAvailable") | .status' | tr -d '"') != "True" ]]
              then
               exit 0
              else
               kubectl get pods --show-labels -o wide
               kubectl get deployments --show-labels
               kubectl get services
               kubectl get ingress
fi