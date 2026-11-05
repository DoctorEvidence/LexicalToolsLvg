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
    default = "https://data.lhncbc.nlm.nih.gov/public/lsg/lvg/2027/release/lvg2027.tgz"
}        
variable LVG_SHA1 { 
    default = "f19d88f155fddf37b41fe522747f2257a6aaac3e"
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