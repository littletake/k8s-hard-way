ls
cd kubeconfig/
kubectl get compomentstatuses --kubeconfig admin.kubeconfig
kubectl get componentstatuses --kubeconfig admin.kubeconfig
kubectl version
kubectl get compo
ls
vim admin.kubeconfig 
kubectl get componentstatuses --kubeconfig admin.kubeconfig
dc ..
cd ..
source .bash_profile
vim /boot/firmware/cmdline.txt 
sudo vim /boot/firmware/cmdline.txt 
sudo apt update
sudo vim /boot/firmware/cmdline.txt 
sudo apt upgrade -y
sudo apt -y install socat conntrack ipset
sudo reboot
ks
ls
ls
cd cert
ls
scp ./ca.pem ubuntu@k8s2:~
scp ./ca.pem ubuntu@k8s3:~
cd ..
ls
vim .bash_profile
source .bash_profile
echo $POD_CIDR
echo $POD_CIDR
cat <<EOF | sudo tee /etc/cni/net.d/10-bridge.conf
{
    "cniVersion": "0.3.1",
    "name": "bridge",
    "type": "bridge",
    "bridge": "cnio0",
    "isGateway": true,
    "ipMasq": true,
    "ipam": {
        "type": "host-local",
        "ranges": [
          [{"subnet": "${POD_CIDR}"}]
        ],
        "routes": [{"dst": "0.0.0.0/0"}]
    }
}
EOF

cat <<EOF | sudo tee /etc/cni/net.d/99-loopback.conf
{
    "cniVersion": "0.3.1",
    "name": "lo",
    "type": "loopback"
}
EOF

cat /etc/cni/net.d/99-loopback.conf
ls
cat <<EOF | sudo tee /etc/cni/net.d/10-bridge.conf
{
    "cniVersion": "0.3.1",
    "name": "bridge",
    "type": "bridge",
    "bridge": "cnio0",
    "isGateway": true,
    "ipMasq": true,
    "ipam": {
        "type": "host-local",
        "ranges": [
          [{"subnet": "${POD_CIDR}"}]
        ],
        "routes": [{"dst": "0.0.0.0/0"}]
    }
}
EOF

tee
sudo reboot
ls
echo $POD_CIDR
cat <<EOF | sudo tee /etc/cni/net.d/10-bridge.conf
{
    "cniVersion": "0.3.1",
    "name": "bridge",
    "type": "bridge",
    "bridge": "cnio0",
    "isGateway": true,
    "ipMasq": true,
    "ipam": {
        "type": "host-local",
        "ranges": [
          [{"subnet": "${POD_CIDR}"}]
        ],
        "routes": [{"dst": "0.0.0.0/0"}]
    }
}
EOF

cd /etc
cd cin
cd cni
ls
cd 
ls
sudo mkdir -p   /etc/cni/net.d   /opt/cni/bin   /var/lib/kubelet   /var/lib/kubernetes   /etc/containerd
echo $HOSTNAME
cd /var/lib/kubelet
ls
sudo cp -ai ${HOSTNAME}-key.pem ${HOSTNAME}.pem /var/lib/kubelet/
ls
cd
ls
sudo cp -ai ${HOSTNAME}-key.pem ${HOSTNAME}.pem /var/lib/kubelet/
ls
cd cert
ls
sudo cp -ai ${HOSTNAME}-key.pem ${HOSTNAME}.pem /var/lib/kubelet/
cd ..
cd kubeconfig/
sudo cp -ai ${HOSTNAME}.kubeconfig /var/lib/kubelet/kubeconfig
cd /var/lib/kube
cd /var/lib/kubernetes/
ls
cd
ls
wget -q --show-progress --https-only --timestamping   https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.18.0/crictl-v1.18.0-linux-arm64.tar.gz   https://github.com/containernetworking/plugins/releases/download/v0.8.6/cni-plugins-linux-arm64-v0.8.6.tgz   https://storage.googleapis.com/kubernetes-release/release/v1.18.6/bin/linux/arm64/kubelet
cd /usr/local/bin
ls
cd
tar -xvf crictl-v1.18.0-linux-arm64.tar.gz
sudo tar -xvf cni-plugins-linux-arm64-v0.8.6.tgz -C /opt/cni/bin/
chmod +x crictl kubelet
sudo mv crictl kubelet /usr/local/bin/
sudo apt -y install containerd runc
echo $POD_CIDR
cat <<EOF | sudo tee /etc/cni/net.d/10-bridge.conf
{
    "cniVersion": "0.3.1",
    "name": "bridge",
    "type": "bridge",
    "bridge": "cnio0",
    "isGateway": true,
    "ipMasq": true,
    "ipam": {
        "type": "host-local",
        "ranges": [
          [{"subnet": "${POD_CIDR}"}]
        ],
        "routes": [{"dst": "0.0.0.0/0"}]
    }
}
EOF

cat <<EOF | sudo tee /etc/cni/net.d/99-loopback.conf
{
    "cniVersion": "0.3.1",
    "name": "lo",
    "type": "loopback"
}
EOF

cat << EOF | sudo tee /etc/containerd/config.toml
[plugins]
  [plugins.cri.containerd]
    snapshotter = "overlayfs"
    [plugins.cri.containerd.default_runtime]
      runtime_type = "io.containerd.runtime.v1.linux"
      runtime_engine = "/usr/sbin/runc"
      runtime_root = ""
EOF

cat <<EOF | sudo tee /var/lib/kubelet/kubelet-config.yaml
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
authentication:
  anonymous:
    enabled: false
  webhook:
    enabled: true
  x509:
    clientCAFile: "/var/lib/kubernetes/ca.pem"
authorization:
  mode: Webhook
clusterDomain: "cluster.local"
clusterDNS:
  - "10.32.0.10"
podCIDR: "${POD_CIDR}"
resolvConf: "/run/systemd/resolve/resolv.conf"
runtimeRequestTimeout: "15m"
tlsCertFile: "/var/lib/kubelet/${HOSTNAME}.pem"
tlsPrivateKeyFile: "/var/lib/kubelet/${HOSTNAME}-key.pem"
EOF

cat <<EOF | sudo tee /etc/systemd/system/kubelet.service
[Unit]
Description=Kubernetes Kubelet
Documentation=https://github.com/kubernetes/kubernetes
After=containerd.service
Requires=containerd.service

[Service]
ExecStart=/usr/local/bin/kubelet \\
  --config=/var/lib/kubelet/kubelet-config.yaml \\
  --container-runtime=remote \\
  --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock \\
  --image-pull-progress-deadline=2m \\
  --kubeconfig=/var/lib/kubelet/kubeconfig \\
  --network-plugin=cni \\
  --register-node=true \\
  --v=2
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl start kubelet
systemctl status kubelet
systemctl enable kubelet
systemctl enable kubelet
systemctl is-enabled kubelet
systemctl status kubelet
wget -q --show-progress --https-only --timestamping    https://storage.googleapis.com/kubernetes-release/release/v1.18.6/bin/linux/arm64/kube-proxy
chmod +x kube-proxy
sudo mv kube-proxy /usr/local/bin/
sudo mkdir -p /var/lib/kube-proxy
sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy/kubeconfig
cd kubeconfig/
sudo mv kube-proxy.kubeconfig /var/lib/kube-proxy/kubeconfig
cd
vim .bash_profile 
echo $NODE_NETWORK
cat <<EOF | sudo tee /var/lib/kube-proxy/kube-proxy-config.yaml
kind: KubeProxyConfiguration
apiVersion: kubeproxy.config.k8s.io/v1alpha1
clientConnection:
  kubeconfig: "/var/lib/kube-proxy/kubeconfig"
mode: "iptables"
clusterCIDR: "${NODE_NETWORK}"
EOF

cat <<EOF | sudo tee /etc/systemd/system/kube-proxy.service
[Unit]
Description=Kubernetes Kube Proxy
Documentation=https://github.com/kubernetes/kubernetes

[Service]
ExecStart=/usr/local/bin/kube-proxy \\
  --config=/var/lib/kube-proxy/kube-proxy-config.yaml
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl start kube-proxy
taketake
systemctl enable kube-proxy
systemctl status kube-proxy
sudo ip route ad 10.2.0.0/24 via 10.0.0.12 dev eth0
ip a
sudo ip route add 10.3.0.0/24 via 10.0.0.13 dev eth0
ip a
cd kubeconfig/
cat <<EOF | kubectl apply --kubeconfig admin.kubeconfig -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRole
metadata:
  annotations:
    rbac.authorization.kubernetes.io/autoupdate: "true"
  labels:
    kubernetes.io/bootstrapping: rbac-defaults
  name: system:kube-apiserver-to-kubelet
rules:
  - apiGroups:
      - ""
    resources:
      - nodes/proxy
      - nodes/stats
      - nodes/log
      - nodes/spec
      - nodes/metrics
    verbs:
      - "*"
EOF

cat <<EOF | kubectl apply --kubeconfig admin.kubeconfig -f -
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: system:kube-apiserver
  namespace: ""
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: system:kube-apiserver-to-kubelet
subjects:
  - apiGroup: rbac.authorization.k8s.io
    kind: User
    name: kubernetes
EOF

kubectl get node
kubectl apply -f coredns-1.7.0.yaml
cd
ls
vim coredns-1.7.0.yaml
kubectl apply -f coredns-1.7.0.yaml
kubectl run test --image busybox:1.28 --restart Never -it --rm -- nslookup kubernetes
kubectl get pods
kubectl logs test
kubectl logs 
kubectl get nondes
kubectl get nodes
nslookup
exit
kubectl describe pods
curl --head http://127.0.0.1:8081
kubectl get pods
kubectl describe pods
exit
ls
kubectl run test --image busybox:1.28 --restart Never -it --rm -- nslookup google.com
kubectl get pods
kubectl get pod
kubectl logs test --previous
kubectl api-resources -o name
kubectl create secret generic kubernetes-the-hard-way   --from-literal="mykey=mydata"
sudo ETCDCTL_API=3 etcdctl get   --endpoints=https://127.0.0.1:2379   --cacert=/etc/etcd/ca.pem   --cert=/etc/etcd/kubernetes.pem   --key=/etc/etcd/kubernetes-key.pem   /registry/secrets/default/kubernetes-the-hard-way | hexdump -C
kubectl get pods
kubectl create deployment nginx --image=nginx
kubectl get pods
kubectl get pods -l app=nginx
kubectl get pods -l app=nginx -o jsonpath="{.items[0].metadata.name}"
POD_NAME=$(kubectl get pods -l app=nginx -o jsonpath="{.items[0].metadata.name}")
echo $POD_NAME
kubectl port-forward $POD_NAME 8081:80
kubectl get pods -l app=nginx
kubectl get pods -l app=nginx
kubectl get pods -l app=nginx
kubectl get pods -l app=nginx
kubectl describe pods 
kubectl get pods -l app=nginx
kubectl run test --image busybox:1.28 --restart Never -it --rm -- nslookup kubernetes
echo $POD_NAME
kubectl port-forward $POD_NAME 8081:80
kubectl logs $POD_NAME
kubectl exec -ti $POD_NAME -- nginx -v
kubectl expose deployment nginx --port 80 --type NodePort
kubectl get svc
kubectl get nodes
kubectl get svc
kubectl run test --image busybox:1.28 --restart Never -it --rm -- nslookup kubernetes
kubectl run test --image busybox:1.28 --restart Never -it --rm -- nslookup kubernetes
kubectl get namespase
kubectl get namespace
kubectl get -n kube-system pod
systemctl status etcd
kubectl get pod -n kube-system
kubectl run test --image busybox:1.28 --restart Never -it --rm -- nslookup google.com
kubectl run test --image busybox:1.28 --restart Never -it --rm -- nslookup google.com
kubectl get pod -n kube-system -o wide
kubectl get svc
kubectl get pod -n kube-system -o wide
kubectl describe -n kube-system -o wide
kubectl describe -n kube-system
kubectl describe pods coredns-5677dc4cdb-s4ghq
kubectl describe -n kube-system pods
kubectl get
kubectl get pod -n kube-system -o wide
kubectl get namespace
kubectl get svc -n kube-system -o wide
docker
runc
kubectl get svc
ls
ls -l $(which sh)
kubectl get pods
kubectl get pods
kubectl logs
kubectl logs test
exit
ks
ls
vim ~/.bash_profile
source .bash_profile
k
k get pods
k get pod --all-namespace -o wide
k get pod --all-namespaces -o wide
k get nodes
kubectl exec -it busybox-bd8fb7cbd-6nt89 nslookup kubernetes
kubectl run test --image busybox:1.28 --restart Never -it --rm -- nslookup kubernetes
k delete pod test
kubectl run test --image busybox:1.28 --restart Never -it --rm -- nslookup kubernetes
k get pods
k stop
k des test
k describe pod test
k describe pod nginx
k get svc
k get deplo
k get deployment
k get deployment
k delete deployment nginx
k get pods
k get svc
k get svc
k delete deployment nginx
k get deployment
k get pod --all-namespaces -o wide
k get svc
k get nodes
k get nodes
k get nodes
k get nodes
k get nodes
k get nodes
k get nodes
k get nodes
ping 10.0.0.13
k get nodes
k get nodes
ks
ls
sudo shutdown now
k 
k get nodes
k get svc
k get pods
k delete svc nginx
k get svc
sudo shutdown now
curl --head http://127.0.0.1:8081
k get svc
k get pods -o wide
k describe pods
k get pod -n kube-system
k get pod -n kube-system -o wide
k describe pod coredns-5677dc4cdb-vbh64
k describe coredns-5677dc4cdb-vbh64
k describe -n kube-system
k describe coredns-5677dc4cdb-vbh64 -n kube-system
k describe pods coredns-5677dc4cdb-vbh64
k get -n kube-system kube-proxy
ls
cat ./cert/kubernetes-key.pem | base64 -w 0
cat ./cert/kubernetes.pem | base64 -w 0
cat ./cert/ca.pem | base64 -w 0
echo $INTERNAL_IP
pwd
exit
k get pods -n kube-system
exit
cd cert
ls
cat ca.pem | base64 -w 0
sudo cp ca.pem /calico-secrets/etcd-ca
sudo mkdir /calico-secrets
sudo cp ca.pem /calico-secrets/etcd-ca
sudo cp kubernetes.pem /calico-secrets/etcd-cert
sudo cp kubernetes-key.pem /calico-secrets/etcd-key
cd /calico-secrets
ls -l
cd ~/cert
ls -l
cd ..
ls
k get pods -n kube-system
free
free -m
free -m
free -m
k get pods
k get pod --all-namespaces
k get svc
k get svc -n kube-system
ls
cd calico
ls
k apply -f calico.yaml 
k get pod --all-namespaces
k get pod --all-namespaces
k get pod --all-namespaces -o wide
k describe calico-kube-controllers-577b5d4647-hh68j -n kube-system
k get pod --all-namespaces -o wide
k get pod --all-namespaces -o wide
k get pod --all-namespaces -o wide
k get pod --all-namespaces -o wide
k describe calico-kube-controllers-577b5d4647-hh68j -n kube-system
exit
 k describe calico-kube-controllers-577b5d4647-hh68j -n kube-system
k get pod --all-namespaces -o wide
ls
k get pod -n kube-system
k get pod -n kube-system
