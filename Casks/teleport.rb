cask "teleport" do
  version "9.2.1"
  sha256 "90cf5b80188b08c9fd39395e4d7ad486b544705f712e10553a5ba861740a5d14"

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
