cask "teleport" do
  version "7.1.2"
  sha256 "b9eac84a9c06d057a551f27caa34ae7b8be1aa71a271504e012202a35aa89e35"

  url "https://get.gravitational.com/teleport-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API"
  homepage "https://goteleport.com/"
  pkg "teleport-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: "teleport-ent"

  caveats do
    license "Apache-2.0"
  end
end
