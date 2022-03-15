cask "teleport-ent@7.3" do
  version "7.3.17"
  sha256 "cb050003e34768255111c215e2e0c29f42c5d4608e5f7e29842a9bd34bc502ab"

  url "https://get.gravitational.com/teleport-ent-#{version}.pkg",
      verified: "get.gravitational.com"
  name "teleport-ent"
  desc "Teleport is a gateway for managing access to clusters of Linux servers via SSH or the Kubernetes API. Enterprise Edition"
  homepage "https://goteleport.com/"
  pkg "teleport-ent-#{version}.pkg"

  uninstall pkgutil: [
    "com.gravitational.teleport"
  ]

  conflicts_with formula: "teleport", cask: ["teleport", "tsh", "teleport-ent@7.0", "teleport-ent@7.1", "teleport-ent@7.2"]

  caveats do
    license "https://dashboard.gravitational.com/web/"
  end
end
