cask "teleport@8.0" do
  version "8.3.6"
  sha256 "7a439ddf122b3a21bdfa0f43f374a309fe1431ee9e2ca2af8dd5f68ae12d0de0"

  url "https://get.gravitational.com/teleport-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API"
  homepage "https://goteleport.com/"
  pkg "teleport-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport-ent", "tsh", "teleport-ent@7.0", "teleport-ent@7.1", "teleport-ent@7.2", "teleport-ent@7.3"]

  caveats do
    license "Apache-2.0"
  end
end
