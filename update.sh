#!/bin/bash

DIR=$(mktemp -d -t teleport-cask-update)
P=$(pwd)
cd $DIR
TOKEN=$(curl -s 'https://quay.io/v2/auth?service=quay.io&scope=repository:gravitational/teleport-ent:pull' | jq -r .token)

echo 'link: </v2/gravitational/teleport-ent/tags/list' > headers.txt

#curl -H "Authorization: Bearer $TOKEN" -s -D headers.txt 'https://quay.io/v2/gravitational/teleport-ent/tags/list' > 1.json

I=0
while (grep -qs '^link: ' headers.txt); do
	NEXT=$(grep '^link: ' headers.txt | sed 's/^.*<//g' | sed 's/>.*$//g')
	curl -H "Authorization: Bearer ${TOKEN}" -s -D headers.txt "https://quay.io/${NEXT}" > ${I}.json
	((I=I+1))
done

versions=($(cat *.json | jq -r '.tags[]' | sort -V | grep '^\d\+\.\d\+\.\d\+$'))
cd $P
rm -rd $DIR

latest=${versions[${#versions[@]}-1]}
latestmajor=$(echo $latest | sed -E 's/([0-9]+).*/\1/')
#echo ${versions[@]}
echo $latestmajor
#echo $latest | sed -e 's/^\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)$/major: \1\nminor: \2\npatch: \3/g'

let "latestamajor = $latestmajor - 1"
aversions=()
for t in ${versions[@]}; do 
	[[ $t =~ ^${latestamajor} ]] && aversions+=(${t});
done
#echo ${aversions[@]}
latesta=${aversions[${#aversions[@]}-1]}

let "latestbmajor = $latestmajor - 2"
bversions=()
for t in ${versions[@]}; do 
	[[ $t =~ ^${latestbmajor} ]] && bversions+=(${t});
done
#echo ${bversions[@]}
latestb=${bversions[${#bversions[@]}-1]}

#echo $latestamajor
#echo $latestbmajor

echo $latest
echo $latesta
echo $latestb
echo
echo inspect changes with 'git diff'

cat > ./Casks/teleport-ent.rb <<EOF
cask "teleport-ent" do
  module Utils
    def self.version
      return "${latest}"
    end
    def self.getsha
      require 'net/http'
      return Net::HTTP.get(URI("https://get.gravitational.com/teleport-ent-#{version}.pkg.sha256")).split()[0]
    end
  end

  version "#{Utils.version}"
  sha256 "#{Utils.getsha}"

  url "https://get.gravitational.com/teleport-ent-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport-ent"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. Enterprise Edition"
  homepage "https://goteleport.com/"
  pkg "teleport-ent-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport", "tsh", "teleport-ent@7.3", "teleport-ent@8.0, teleport-ent@9.0, teleport-ent@10.0"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
EOF

cat > ./Casks/teleport-ent@${latestamajor}.0.rb <<EOF
cask "teleport-ent@${latestamajor}.0" do
  module Utils
    def self.version
      return "${latesta}"
    end
    def self.getsha
      require 'net/http'
      return Net::HTTP.get(URI("https://get.gravitational.com/teleport-ent-#{version}.pkg.sha256")).split()[0]
    end
  end

  version "#{Utils.version}"
  sha256 "#{Utils.getsha}"

  url "https://get.gravitational.com/teleport-ent-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport-ent"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. Enterprise Edition"
  homepage "https://goteleport.com/"
  pkg "teleport-ent-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport", "tsh", "teleport-ent@7.3", "teleport-ent@8.0, teleport-ent@9.0, teleport-ent"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
EOF

cat > ./Casks/teleport-ent@${latestbmajor}.0.rb <<EOF
cask "teleport-ent@${latestbmajor}.0" do
  module Utils
    def self.version
      return "${latestb}"
    end
    def self.getsha
      require 'net/http'
      return Net::HTTP.get(URI("https://get.gravitational.com/teleport-ent-#{version}.pkg.sha256")).split()[0]
    end
  end

  version "#{Utils.version}"
  sha256 "#{Utils.getsha}"

  url "https://get.gravitational.com/teleport-ent-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport-ent"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. Enterprise Edition"
  homepage "https://goteleport.com/"
  pkg "teleport-ent-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport", "tsh", "teleport-ent@7.3", "teleport-ent@8.0, teleport-ent"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
EOF
