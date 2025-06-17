# Documentation for bake file
# https://docs.docker.com/build/bake/reference/
#

variable "REPO" {
    default = "doctorevidence"
}

variable "TAG" {
  default = "latest"
}

variable LVG_URL { 
    default = "https://data.lhncbc.nlm.nih.gov/public/lsg/lvg/2025/release/lvg2025.tgz"
}        
variable LVG_SHA1 { 
    default = "777aad51bef5edbe434b46208a66d96e626771b1"
}   


target "default" {
    dockerfile = "Dockerfile"
    context = "."
    pull = true
    args = {
        LVG_URL = LVG_URL
        LVG_SHA1 = LVG_SHA1
    }
    tags = ["${REPO}/lexical-tools-lvg:${TAG}"]
    platforms = ["linux/amd64"]
}