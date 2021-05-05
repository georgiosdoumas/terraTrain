# AWS Info
region=""                       # choose your region eg eu-central-1, or ap-east-1, or us-east-1 etc
name=""                         # Something to identify your instances, can be your username like bob-geldof
caseNo=""                       # you can specify your case no here. Later you can find it by case no (can be left empty)
os_name=""                      # use "ubuntu" or  "redhat" or "centos"
os_version=""                   # for ubuntu 16.04,18,04 etc. for redhat 7.8, 7.1, 8.1

# Managers Info
manager_count="3"
manager_instance_type="c4.xlarge"

# MSR  Info
msr_count="3"
msr_instance_type="c4.xlarge"

# Workers Infor
worker_count="3"
worker_instance_type="t2.micro"
win_worker_count="0"
win_worker_instance_type="c4.xlarge"

# MKE MSR MCR info
# Please change only the following informations if you want to use `tt-reinstall`.
mcr_version="19.03.14"          # Please use specific minor engine version.
mke_version="3.3.4"             # MKE Version
msr_version="2.8.2"             # MSR Version
image_repo="docker.io/mirantis" #For older version use docker.io/docker , specifically use : 
# docker.io/docker for images up-to: 3.1.14, 3.2.7, 3.3.1  (taken from https://hub.docker.com/r/docker/ucp/tags?page=3&ordering=name ) 
# docker.io/mirantis for images : 3.1.15+, 3.2.8+, 3.3.2+  (taken from https://hub.docker.com/r/mirantis/ucp/tags?page=1&ordering=name ) 
#---------------------------------------------------------------------------------------------------------------------------
# Check Again Please

# Following lines are autogenerated so please don't change
