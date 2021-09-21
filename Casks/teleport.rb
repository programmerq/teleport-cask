cask "teleport" do
  version "7.1.3"
  sha256 "d4956c8f85a26f71ea9827d1e26181fd74b54f939e33ed5da79b63ad901bc811"

  url "https://get.gravitational.com/teleport-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API"
  homepage "https://goteleport.com/"
  pkg "teleport-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport"
  conflicts_with cask: "teleport-ent"
  conflicts_with cask: "tsh"

  caveats do
    license "Apache-2.0"
  end
end
