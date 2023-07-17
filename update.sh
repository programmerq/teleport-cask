#!/bin/bash
set -e
DIR=$(mktemp -d -t teleport-cask-update)
REGISTRY=public.ecr.aws
REPOSITORY=gravitational/teleport-ent
P=$(pwd)
cd $DIR
#TOKEN=$(curl -s "https://quay.io/v2/auth?service=quay.io&scope=repository:gravitational/teleport-ent:pull" | jq -r .token)
TOKEN=$(curl -s "https://public.ecr.aws/token/?service=public.ecr.aws&scope=aws" | jq -r .token)

echo 'link: </v2/gravitational/teleport-ent/tags/list>; rel="next"' > headers.txt
echo 'link: </v2/gravitational/teleport/tags/list>; rel="next"' > ossheaders.txt

#curl -H "Authorization: Bearer $TOKEN" -s -D headers.txt 'https://quay.io/v2/gravitational/teleport-ent/tags/list' > 1.json

I=0
while (grep -qs '^link: ' headers.txt); do
	NEXT=$(grep '^link: ' headers.txt | sed | sed 's/.*<\([^>]*\)>[; ]*rel[ ="]*next.*$/\1/g')
	curl -H "Authorization: Bearer ${TOKEN}" -s -D headers.txt "https://${REGISTRY}${NEXT}" > ent${I}.json
	((I=I+1))
done

I=0
while (grep -qs '^link: ' ossheaders.txt); do
	NEXT=$(grep '^link: ' ossheaders.txt | sed | sed 's/.*<\([^>]*\)>[; ]*rel[ ="]*next.*$/\1/g')
	curl -H "Authorization: Bearer ${TOKEN}" -s -D ossheaders.txt "https://${REGISTRY}${NEXT}" > oss${I}.json
	((I=I+1))
done

versions=($(cat ent*.json | jq -r '.tags[]' | sort -V | grep '^\d\+\.\d\+\.\d\+$' | grep -v '^999\.0\.3'))
ossversions=($(cat oss*.json | jq -r '.tags[]' | sort -V | grep '^\d\+\.\d\+\.\d\+$' | grep -v '^999\.0\.3'))
cd $P
rm -rfd $DIR

latest=${versions[${#versions[@]}-1]}
latestmajor=$(echo $latest | sed -E 's/([0-9]+).*/\1/')
#echo ${versions[@]}
#echo $latestmajor
#echo $latest | sed -e 's/^\([0-9]*\)\.\([0-9]*\)\.\([0-9]*\)$/major: \1\nminor: \2\npatch: \3/g'

osslatest=${ossversions[${#ossversions[@]}-1]}

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

#echo Enterprise Versions:,OSS Versions: | column -s, -t
printf "%-23s %-15s\n" 'Enterprise Versions:' 'OSS Versions:'
#echo $latest,$osslatest | column -s, -t
printf "%-23s %-15s\n" "$latest" "$osslatest"
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

  conflicts_with formula: "teleport", cask: ["teleport", "teleport-ent@${latestamajor}.0, teleport-ent@${latestbmajor}.0"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
EOF

cat > ./Casks/teleport.rb <<EOF
cask "teleport" do
  module Utils
    def self.version
      return "${osslatest}"
    end
    def self.getsha
      require 'net/http'
      return Net::HTTP.get(URI("https://get.gravitational.com/teleport-#{version}.pkg.sha256")).split()[0]
    end
  end

  version "#{Utils.version}"
  sha256 "#{Utils.getsha}"

  url "https://get.gravitational.com/teleport-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API."
  homepage "https://goteleport.com/"
  pkg "teleport-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport-ent", "teleport-ent@${latestamajor}.0, teleport-ent@${latestbmajor}.0"]

  caveats do
    license "Apache-2.0"
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

  conflicts_with formula: "teleport", cask: ["teleport", teleport-ent@${latestbmajor}.0, teleport-ent"]

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

  conflicts_with formula: "teleport", cask: ["teleport", teleport-ent@${latestamajor}.0, teleport-ent"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
EOF

cat > ./Casks/tsh.rb <<EOF
cask "tsh" do
  module Utils
    def self.version
      return "${osslatest}"
    end
    def self.getsha
      require 'net/http'
      return Net::HTTP.get(URI("https://get.gravitational.com/tsh-#{version}.pkg.sha256")).split()[0]
    end
  end

  version "#{Utils.version}"
  sha256 "#{Utils.getsha}"

  url "https://get.gravitational.com/tsh-#{version}.pkg",
      verified: "get.gravitational.com"
  name "tsh"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. TSH client only"
  homepage "https://goteleport.com/"
  pkg "tsh-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport.tsh"
  ]

  caveats do
    license "Apache-2.0"
  end
end
EOF

git diff | cat
