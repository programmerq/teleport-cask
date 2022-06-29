cask "teleport-ent@7.3" do
  version "7.3.23"
  sha256 "4d6b5dd3488edb685cc3b6bf855732d2a00ebd254eeb4fa5b31b9c88aea91e27"

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
