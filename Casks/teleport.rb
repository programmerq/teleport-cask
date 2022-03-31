cask "teleport" do
  version "9.0.2"
  sha256 "767f7e5cbf1ec0be5d88e5fefe622746c91ef3d4cc55cf26ce969e7802222db7"

  url "https://get.gravitational.com/teleport-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API"
  homepage "https://goteleport.com/"
  pkg "teleport-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport-ent", "tsh", "teleport-ent@7.0", "teleport-ent@7.1", "teleport-ent@7.2", "teleport-ent@7.3", "teleport-ent@8.0"]

  caveats do
    license "Apache-2.0"
  end
end
